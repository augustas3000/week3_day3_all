require 'pg'

class SqlRunner
  # class method to abstract sql functionality in pizza_order.rb and cutomer.rb

  def self.run(sql_command, values_array = [])
    # in order to use ensure, we need begin statement:
    begin
      db = PG.connect({dbname: 'music_collection', host: 'localhost'})
      db.prepare("query", sql_command)
      result = db.exec_prepared("query", values_array)
    ensure
      # no matter what happens ensure connection is closed if the connection exists - this if is in case the PG.connect raises an error or the prep or exec  methods.
      db.close() if db != nil
    end

    return result
  end

end
