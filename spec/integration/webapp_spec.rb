require "spec_helper"
require "rack/test"
require_relative "../../webapp"

describe Application do 
  include Rack::Test::Methods

  let(:app) { Application.new }

  context 'GET /albums' do
    it "returns html with a list of albums" do
      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include('Title: Surfer Rosa')
      expect(response.body).to include('Released: 1988')
    end
  end

    it "returns html index" do
      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include('Surfer Rosa')
      expect(response.body).to include('Released: 1988')
      expect(response.body).to include('<a href="/albums/2">Surfer Rosa</a>')
    end
 

  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_albums_table
  end

  context "POST /albums" do
    it "returns 200 OK with empty body" do
     
      response = post("/albums", title: "Bla", release_year: "1980", artist_id: "1")
      
      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      response =get("/albums")
      expect(response.body).to include("Bla")
    end
  end

  it"returns album by id" do

    response= get('/albums/1')

    expect(response.body).to include("<h1>Doolittle</h1>")
    expect(response.body).to include("Release year: 1989")
    expect(response.body).to include("Artist: Pixies")
  end

  context 'GET /artists' do
    it "returns 200 OK with the right content" do
      response = get('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to include('Artist: Pixies')
      expect(response.body).to include('Genre: Rock')
      expect(response.body).to include('<a href="/artists/1">Pixies</a>')
    end

    it"returns artist by id" do

      response= get('/artists/3')
  
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Taylor Swift</h1>')
      expect(response.body).to include('<p>Pop</p>')
    end
  end

  def reset_artists_table
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_artists_table
  end
  context "POST /artists" do
    it "returns 200 OK with empty body" do
    
      response = post("/artists", name: "test1", genre: "teste1")
      
      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      response = get("/artists")
      expect(response.body).to include("test1")
    end
  end

  context "GET /album/new" do
    it 'returns the form page' do
      response = get('/album/new')
  
      expect(response.status).to eq(200)
      expect(response.body).to include('"/albums" method="POST"')
      expect(response.body).to include('name="title')
      expect(response.body).to include('<input type="text" name="release_year">')
  
    end
  end
  
  context "POST /albums" do
    it "validate" do
      response = post(
        '/albums',
        invalid_album: 'Welcome',
        invalide_year: "1999",
        invalid_artist_id: '1'
      ) 
      expect(response.status).to eq (400)
    end

    it 'returns a success page' do
      response = post(
        '/albums',
        title: 'Welcome',
        release_year: '1999',
        artist_id: '1'
      )
  
      expect(response.status).to eq(200)
      # expect(response.body).to include('<p>Your post has been added!</p>')
    end
  end

  context "GET /artist/new" do
    it 'returns the form page for artist' do
      response = get('/artist/new')
  
      expect(response.status).to eq(200)
      expect(response.body).to include('"/artists" method="POST"')
      expect(response.body).to include('name="name')
      expect(response.body).to include('<input type="text" name="genre">')
  
    end
  end

  context "POST /artists" do

    it 'returns a success page for artist' do
      response = post(
        '/artists',
        name: 'Bob Dylan',
        genre: 'Rock',
      )
  
      expect(response.status).to eq(200)
      # expect(response.body).to include('<p>Your post has been added!</p>')
    end
  end
end