Polymer
  is: "mocs-page"
  properties:
    items: Array
    orders: Array
    currentOrder: Object
    selected:
      type: Number
      value: 0
  ready: ->
    this.orders = [{id: 1, name: "odin"}, {id: 2, name: "dva"}]
    this.currentOrder = this.orders[0]

  addToCart: (e) ->
    debugger
    console.log Polymer.dom(e).localTarget._id
