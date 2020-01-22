require 'pg'

require_relative '../db/sql_runner.rb'

class Customer
  attr_reader :id, :first_name, :last_name
  attr_accessor :first_name, :last_name
  # options hash to be input. options hash will have all or some column values to generate a row - a customer object.

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save
    sql = "INSERT INTO customers
           (first_name, last_name) VALUES
           ($1, $2) RETURNING id"

    values = [@first_name, @last_name]
    result = SqlRunner.run(sql,values)
    @id = result[0]["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  # # suppose we change names(first and last) using attr_acessor of a specific customer object(as far as SQL is concerned, it represents a row in customers table),and then want to update the database with these changes:
  # def update()
  #   # 1) create a connection object using PG gem
  #   db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
  #   # write an sql query for updating the database (specifying which columns will be referenced by which numbers $1-$3),
  #   sql = "UPDATE customers SET (first_name, last_name)=
  #         ($1, $2)
  #         WHERE id = $3"
  #   # provide actual instance variables with values specific to the customer object(a row of data for sql) - 1,2,3 consecutively..
  #   values = [@first_name, @last_name, @id]
  #   # provide query name and actual sql written to prepare method.
  #   db.prepare("update", sql)
  #   # execute by providing query name, and values to be used for updating:
  #   db.exec_prepared("update", values)
  #   db.close
  # end

  def self.all()
    sql = "SELECT * FROM customers;"
    customers = SqlRunner.run(sql)

    return customers.map {|customer_hash| Customer.new(customer_hash)}
  end

  def orders
    sql = "SELECT * FROM pizza_orders WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)


    order_objects_array = results.map {|order| PizzaOrder.new(order)}

    return order_objects_array
  end

end
