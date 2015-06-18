Polymer
  is: "mocs-item"
  properties:
    _id: Number
    _name: String
    _price: Number
  addToOrder: (e)->
    this.fire('add-to-order', {item: {id: +this._id, name: this._name, price: this._price}})
