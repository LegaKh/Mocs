Polymer
  is: "mocs-item"
  properties:
    _id: Number
    _name: String
    _price: Number
  addToCart: ->
    this.fire('add-to-cart')
