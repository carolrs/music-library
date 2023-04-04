# {{ GET/POST }} {{ /albums}} Route Design Recipe

![Sequence diagram for Web](docs/music_library.png?raw=true "sequence diagram for web")

## 1. Design the Route Signature
```
post '/albums' do
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
  
 post: http://localhost:9292/albums  --data= body
  
 get :  http://localhost:9292/albums

 get(id) :  http://localhost:9292/albums/id

 get :  http://localhost:9292/artists
  ```
## 2. Design the Response

```
GET:
Response for 200 OK
#"Doolittle,Surfer Rosa,Waterloo,Super Trouper,Bossanova,Lover,Folklore,I Put a Spell on You,Baltimore,Here Comes the Sun,Fodder on My Wings,Ring Ring"

POST:
response for 200 OK
#""

```
# Request:
```
GET /albums
curl --location --request GET 'http://localhost:9292/albums' 
```
# Expected response:

```
GET/albums
Response for 200 OK
#"Doolittle,Surfer Rosa,Waterloo,Super Trouper,Bossanova,Lover,Folklore,I Put a Spell on You,Baltimore,Here Comes the Sun,Fodder on My Wings,Ring Ring"

```
# Request:
```
POST/albums --body
curl --location --request POST 'http://localhost:9292/albums' \
--form 'title="Voyage"' \
--form 'release_year="2022"' \
--form 'artist_id="2"'
```
# Expected response:
```
response for 200 OK
#""
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

 context 'GET /albums' do
    it "returns 200 OK with the right content" do
  
      response = get('/albums')

      result = "Doolittle,Surfer Rosa,Waterloo,Super Trouper,Bossanova,Lover,Folklore,I Put a Spell on You,Baltimore,Here Comes the Sun,Fodder on My Wings,Ring Ring"
      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq(result)
    end
    context "Get/albums(id)"do 
      it"returns album by id" do

        response= get('/albums/1')

        expect(response.status).to eq(200)
        expect(response.body).to eq("Doolittle")
      end

    end
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

  context 'GET /artists' do
    it "returns 200 OK with the right content" do
      response = get('/artists')

      result = "Pixies,ABBA,Taylor Swift,Nina Simone"
    
      expect(response.status).to eq(200)
      expect(response.body).to eq(result)
    end
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
```