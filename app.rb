# file: app.rb
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

album_repository = AlbumRepository.new
artist = ArtistRepository.new

p album_repository.find(1).title
p album_repository.find(1).release_year

puts "----------------------"
# Print out each record from the result set .
album_repository.all.each do |album|
  p "#{album.title}, #{album.release_year}"
end

# artist.all.each do |album|
#   p album 
# end