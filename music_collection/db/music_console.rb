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

artist3.artist_name = "2 Chains"
artist3.update

album3.album_name = "Almost There"
album3.update

# artist2.save
# artist3.save
#

# album2.save
# album3.save



binding.pry
nil
