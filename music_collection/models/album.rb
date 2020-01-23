require 'pg'
require 'pry'

require_relative '../db/music_sql_runner.rb'


class Album

  attr_accessor :album_name, :id, :artist_id


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @album_name = options['album_name']
    @artist_id = options['artist_id']
  end

  def save()

    sql = "INSERT INTO albums
    (

      album_name,
      artist_id
    ) VALUES
    (
      $1, $2
    )
    RETURNING id"
    # The RETURNING keyword in PostgreSQL gives an opportunity to return from the insert or update statement the values of any columns after the insert or update was run. 
    values = [@album_name,@artist_id]
    result = SqlRunner.run(sql, values)

    # good way to check what result from running the query is:
    # result.each do |result|
    #   for k, v in result
    #     puts "Column: --#{k}-- returned with value of: --#{v}--"
    #   end
    # end

    @id = result[0]["id"].to_i

  end


  def self.all()
    sql = "SELECT * FROM albums"
    result = SqlRunner.run(sql)
    array_of_artist_objects = result.map {|artist_hash| Artist.new(artist_hash)}
    return array_of_artist_objects
  end

  def self.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def check_artist
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    artist_object = Artist.new(result[0])
    return artist_object
  end

  def update
    sql = "UPDATE albums SET album_name = $1
          WHERE id = $2"
    values = [@album_name, @id]
    SqlRunner.run(sql, values)
  end

  # Delete Artists/Albums
  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)

    albums_object = Artist.new(results[0])
    return albums_object
  end

end
