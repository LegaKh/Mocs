Polymer
  is: "mocs-item"
  properties:
    id: Number
    name: String
    price: Number
  addToOrder: (e)->
    this.fire('add-to-order', {item: {id: +this.id, name: this.name, price: this.price}})
