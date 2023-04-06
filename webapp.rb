require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'

  end

  post '/albums' do
    if params[:title] == nil || params[:release_year] == nil || params[:artist_id] == nil
      status 400
      return ''
    end

    repo = AlbumRepository.new
    title = params[:title]
    release_year = params[:release_year]
    artist_id = params[:artist_id]
    album = Album.new(nil, title, release_year, artist_id)

    repo.create(album)
    return ''
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:albums)
  end
 
  get '/albums/:id' do
    repo = AlbumRepository.new
    artist_repo = ArtistRepository.new
    @album = repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)
    return erb(:index)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    return erb(:artists)
  end

  get '/artists/:id' do
    repo = ArtistRepository.new
    artist_id = params[:id]
    @artist = repo.find(artist_id) 
    return erb(:artists_id)
  end

  post '/artists' do
     repo = ArtistRepository.new

    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]
    
    repo.create(artist)
    return ''
  end

  get '/album/new' do 
    return erb(:new_album)
  end

  get '/artist/new' do 
    return erb(:new_artist)
  end
  
  # configure :development do
  #   register Sinatra::Reloader
  # end
end

