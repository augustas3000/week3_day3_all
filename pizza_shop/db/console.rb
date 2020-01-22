require 'pry'

require_relative '../models/pizza_order.rb'
require_relative '../models/customer.rb'


# one to many - one customer can have many pizza orders, but pizza order only belongs to one customer.

PizzaOrder.delete_all()
Customer.delete_all()

# first generate a customer object because pizza order cannot exist without a customers id which is a foreign key:
customer1 = Customer.new({
            'first_name' => 'Deirdre',
            'last_name' => 'Barlow'
  })
# update database table customers with custoemr object
customer1.save()


# now create a pizza order object using customer1.id as a customer_id for foreign key to link the two rows from diff tables
order1 = PizzaOrder.new(
  {
    'customer_id' => customer1.id,
    'topping' => 'uranium',
    'quantity' => 2
  }
)

order2 = PizzaOrder.new(
  {
    'customer_id' => customer1.id,
    'topping' => 'uranium',
    'quantity' => 2
  }
)

order1.save()
order2.save()

# updating customer1 data in database:
# order1.delete





binding.pry
nil
