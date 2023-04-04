# # file: app.rb
# require_relative 'lib/database_connection'
# require_relative 'lib/album_repository'
# require_relative 'lib/artist_repository'

# DatabaseConnection.connect('music_library')

# class Application

#   # The Application class initializer
#   # takes four arguments:
#   #  * The database name to call `DatabaseConnection.connect`
#   #  * the Kernel object as `io` (so we can mock the IO in our tests)
#   #  * the AlbumRepository object (or a double of it)
#   #  * the ArtistRepository object (or a double of it)
#   def initialize(database_name, io, album_repository, artist_repository)
#     @io = io
#     @album_repository = album_repository
#     @artist_repository = artist_repository
#   end

#   def run
#     # "Runs" the terminal application
#     # so it can ask the user to enter some input
#     # and then decide to run the appropriate action
#     # or behaviour.

#     # Use `@io.puts` or `@io.gets` to
#     # write output and ask for user input.
#     @io.puts "Welcome to the music library manager!"
#     @io.puts "What would you like to do?"
#     @io.puts "1 - List all albums or 2 - List all artists"

#     choise = @io.gets.chomp 

#     if choise == "1"
#       @io.puts "Here is the list of albums:"
#       albums = @album_repository.all
      
#       albums.each do |album|
#         @io.puts "#{album.title}"
#       end
#     elsif choise == "2"
#       @io.puts "Here is the list of artists:"
#       artists = @artist_repository.all
      
#       artists.each do |artist|
#         @io.puts "#{artist.name}"
#       end
#     end
#   end
# end

# # Don't worry too much about this if statement. It is basically saying "only
# # run the following code if this is the main file being run, instead of having
# # been required or loaded by another file.
# # If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
# if __FILE__ == $0
#   app = Application.new(
#     'music_library',
#     Kernel,
#     AlbumRepository.new,
#     ArtistRepository.new
#   )
#   app.run
# end