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
    @currentOrder = @orders[0] or {id: null, items: [], aasm_state: 'new'}

  addToOrder: (e) ->
    @currentOrder.items.push e.detail.item
    @sendOrder()

  sendOrder: ->
    req = @$.saveOrder
    req.url="/orders/" + @currentOrder.id or ''
    req.method = if @currentOrder.id then 'PATCH' else 'POST'
    req.body = JSON.stringify {items_ids: @orderItemsIds()}
    req.headers = {"X-CSRF-Token": @csrfToken}
    req.generateRequest()
    debugger

  orderItemsIds: ->
    @currentOrder.items.map (i)->
      i.id

  handleOrder: ->
    debugger
