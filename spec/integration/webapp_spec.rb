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
      # Send a POST request to /submit
      # with some body parameters
      # and returns a response object we can test.
      response = post("/albums", title: "Bla", release_year: "1980", artist_id: "1")
      # Assert the response status code and body.
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

      result = "Pixies,ABBA,Taylor Swift,Nina Simone"
    
      expect(response.status).to eq(200)
      expect(response.body).to eq(result)
    end

    it"returns artist by id" do

      response= get('/artists/3')
  
      expect(response.status).to eq(200)
      expect(response.body).to eq("Taylor Swift")
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
end