Polymer
  is: "mocs-page"
  properties:
    items: Array
    orders: Array
    currentOrder: Object
    selectedTab:
      type: Number
      value: 0

  csrfToken: do ->
    token = document.querySelector('meta[name="csrf-token"]')
    if token then token.getAttribute('content') else ''

  setCurrentOrder: ->
    @currentOrder = @orders[0] or @createNewOrder()

  createNewOrder: ->
    @orders.unshift {id: null, items: [], aasm_state: 'new'}
    @setCurrentOrder()

  addToOrder: (e) ->
    return if @currentOrder.aasm_state isnt 'new'
    item_id = @orderItemsIds().filter (i)->
      i is e.detail.item.id
    if item_id.length is 0
      @currentOrder.items.push e.detail.item
      @sendOrder()

  sendOrder: ->
    req         = @$.saveOrder
    req.url     = "/orders/#{@currentOrder.id or ''}"
    req.method  = if @currentOrder.id then 'PATCH' else 'POST'
    req.body    = JSON.stringify {items_ids: @orderItemsIds()}
    req.headers = {"X-CSRF-Token": @csrfToken}
    req.generateRequest()

  orderItemsIds: ->
    @currentOrder.items.map (i)-> i.id

  handleUpdatedOrder: (e, response)->
    @currentOrder = response.response
    @handleOrder(e, response)

  handleOrder: (e, response)->
    @replaceOrder(response.response)
    @$.ordersList.render()
    @$.toast.show()

  replaceOrder: (order)->
    @orders.forEach ((o)->
      if o.id is null or o.id is order.id
        @splice('orders',(@orders.indexOf o), 1, order)).bind @

  changeOrderState: (e, detail)->
    req         = @$.changeOrderState
    req.url     = "/orders/#{@currentOrder.id}/update_state"
    req.body    = JSON.stringify detail
    req.headers = {"X-CSRF-Token": @csrfToken}
    req.generateRequest()
