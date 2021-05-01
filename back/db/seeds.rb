# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
c1 = Customer.create(name: 'Gabriel Henrique', phone: '(62) 9 9443-3917', birthday: Date.today)
c2 = Customer.create(name: 'Victor Mamede', phone: '(62) 9 9443-3917', birthday: Date.today)
p1 = Product.create(name: 'Produto 1', price: 200)
p2 = Product.create(name: 'Produto 2', price: 250)

Order.create(customer: c1, price: p1.price, product_ids: [p1.id] )
Order.create(customer: c2, price: 450, product_ids: [p1.id, p2.id] )