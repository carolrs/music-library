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
    repo = AlbumRepository.new
    title = params[:title]
    release_year = params[:release_year]
    artist_id = params[:artist_id]
    album = Album.new(nil, title, release_year, artist_id)

    repo.create(album)
    return ''
    # This route is not executed (the method doesn't match).
  end

  get '/albums' do
    repo = AlbumRepository.new
    albums = repo.all

    response = albums.map do|album|
      album.title

    end.join(',')
  end

  get '/albums/:id' do
    repo = AlbumRepository.new
    album_id = params[:id]
    album = repo.find(album_id)
    album.title
  end

  get '/artists' do
    repo = ArtistRepository.new
    artists = repo.all

    response = artists.map do|artist|
      artist.name

    end.join(',')
  end

  get '/artists/:id' do
    repo = ArtistRepository.new
    artist_id = params[:id]
    artist = repo.find(artist_id)
    artist.name
  end

  post '/artists' do
       repo = ArtistRepository.new

    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]
    

    repo.create(artist)

    return ''
  end

  configure :development do
    register Sinatra::Reloader
  end
end