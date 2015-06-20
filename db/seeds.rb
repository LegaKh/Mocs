# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Item.create([ {name: 'Banana',     price: 10 },
              {name: 'Coconut',    price: 12 },
              {name: 'Apple',      price: 5  },
              {name: 'Milk',       price: 7  },
              {name: 'Juice',      price: 12 },
              {name: 'Bread',      price: 4  },
              {name: 'Oil',        price: 22 },
              {name: 'Salt',       price: 2  },
              {name: 'Mango',      price: 9  },
              {name: 'Carburetor', price: 300},
           ])
