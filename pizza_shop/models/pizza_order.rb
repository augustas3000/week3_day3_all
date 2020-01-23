require('pg')
require_relative '../db/sql_runner.rb'

class PizzaOrder

  attr_accessor :first_name, :last_name, :topping, :quantity
  attr_reader :id

  def initialize(options)
    @topping = options['topping']
    @quantity = options['quantity'].to_i
    @id = options['id'].to_i if options['id']
    # foreign key to ref customer objects, comes from customer_id column of customers table
    @customer_id = options['customer_id'].to_i
  end

  def save()
    sql = "INSERT INTO pizza_orders
    (
      topping,
      quantity,
      customer_id
    ) VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@topping, @quantity, @customer_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def update()
    sql = "
    UPDATE pizza_orders SET (
      topping,
      quantity,
      customer_id
    ) =
    (
      $1,$2, $3
    )
    WHERE id = $4"
    values = [@topping, @quantity, @customer_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM pizza_orders where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM pizza_orders WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    order_hash = results.first
    order = PizzaOrder.new(order_hash)
    return order
  end

  def self.delete_all()
    sql = "DELETE FROM pizza_orders"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM pizza_orders"
    orders = SqlRunner.run(sql)
    return orders.map { |order| PizzaOrder.new(order) }
  end

  def customer
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    results = SqlRunner.run(sql, values)
    customer_data = results[0]
    customer_obj = Customer.new(customer_data)
    return customer_obj
  end

end
