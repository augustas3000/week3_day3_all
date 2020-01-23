require 'pry'

require_relative '../models/album.rb'
require_relative '../models/artist.rb'

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new(
  {
    'artist_name' => 'DMX'
  }
)

artist2 = Artist.new(
  {
    'artist_name' => 'Pharcyde'
  }
)

artist3 = Artist.new(
  {
    'artist_name' => 'DITC'
  }
)

artist1.save
artist2.save
artist3.save

album1 = Album.new(
  {
    'album_name' => 'Grand Champ',
    'artist_id' => artist1.id
  }
)

album2 = Album.new(
  {
    'album_name' => 'Plain Rap',
    'artist_id' => artist1.id
  }
)

album3 = Album.new(
  {
    'album_name' => 'Sessions',
    'artist_id' => artist3.id
  }
)

album1.save
album2.save
album3.save


Artist.all()

artist3.artist_name = "2 Chains"
artist3.update

#
# album3.album_name = "Almost There"
# album3.update

# artist2.save
# artist3.save
#

# album2.save
# album3.save

# binding.pry
# nil

# PG::Result information:

#<PG::Result:0x007fd5b88e61e8 status=PGRES_TUPLES_OK ntuples=1 nfields=1 cmd_tuples=1>
#
# status: It describes query executed successfully or not.
#
# ntuples: It returns the total number of tuples which we get in the query result.
#
# nfields: Returns the number of columns in the query result.
#
# cmd_tuples: Returns the number of tuples (rows) affected by the SQL command.


# PG::result object is actually a collection of Hash and it contains data retrieved in string format(No matter what its data type of column as per ruby). It does not perform any conversion to convert the values to the appropriate Ruby type, other than NULL to nil
