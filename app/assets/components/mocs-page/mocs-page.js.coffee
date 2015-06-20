Polymer
  is: "mocs-page"
  properties:
    items: Array
    orders: Array
    filteredOrders: Array
    currentOrder: Object
    selectedTab:
      type: Number
      value: 0
    filterState:
      type: Number
      value: 0
      observer: 'applyFilter'

  csrfToken: do ->
    token = document.querySelector('meta[name="csrf-token"]')
    if token then token.getAttribute('content') else ''

  setCurrentOrder: ->
    @filteredOrders = @orders
    @currentOrder = @orders[0] or @createNewOrder()

  createNewOrder: ->
    if @currentOrder?.id isnt null
      @orders.unshift {id: null, items: [], aasm_state: 'new'}
      @currentOrder = @orders[0]
    else
      @$.toast_already_created.show()

  addToOrder: (e) ->
    return @$.toast_add_new_order.show() if @currentOrder.aasm_state isnt 'new'
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
    @$.toast_saved.show()

  replaceOrder: (order)->
    @splice('orders',(@orders.indexOf o), 1, order) for o in @orders when o.id is null or o.id is order.id

  changeOrderState: (e, detail)->
    req         = @$.changeOrderState
    req.url     = "/orders/#{detail.id}/update_state"
    req.body    = JSON.stringify detail
    req.headers = {"X-CSRF-Token": @csrfToken}
    req.generateRequest()

  applyFilter: ->
    return @filteredOrders = @orders if @filterState is 0
    @filteredOrders =
    if @filterState is 1
      order for order in @orders when order.aasm_state is 'new'
    else
      order for order in @orders when order.aasm_state isnt 'new'

  handleError: ->
    @$.toast_log_in.show()
