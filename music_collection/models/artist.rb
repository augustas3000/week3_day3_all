require 'pg'

require_relative '../db/music_sql_runner.rb'


# You have been asked to create an app that will allow a music collector to manage their collection of CDs/records.
#
# In their console they would like to be able to:
#
# Create and Save Artists
# Create and Save Albums
# List All Artists/Albums
#
# List all the albums by an artist
# Get the artist for a particular album
# Every artist should have a name, and each album should have a name/title, genre and artist ID.

class Artist

  attr_reader :id, :name
  attr_accessor :artist_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @artist_name = options['artist_name']
  end

  def save
    sql = "INSERT INTO artists
    (
      artist_name
    ) VALUES
    (
      $1
    )
    RETURNING id"
    values = [@artist_name]

    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM artists"
    result = SqlRunner.run(sql)
    array_of_artist_objects = result.map {|artist_hash| Artist.new(artist_hash)}
    return array_of_artist_objects
  end

  def self.delete_all
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def check_albums
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]

    result = SqlRunner.run(sql, values)
    array_of_album_objects = result.map {|album_hash| Album.new(album_hash)}
    return array_of_album_objects
  end

  def update
    sql = "UPDATE artists SET artist_name = $1
          WHERE id = $2"
    values = [@artist_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def self.find_by_id(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    
    artist_object = Artist.new(results[0])
    return artist_object
  end


end
