require_relative '../app.rb'
require_relative '../lib/database_connection'

data = DatabaseConnection.connect('music_library')

describe Application do  
  it "return albums when user chooses 1" do
    io = double :io
    albums = AlbumRepository.new
    artists = ArtistRepository.new 

    app = Application.new(data, io, albums, artists)

    expect(io).to receive(:puts).with("Welcome to the music library manager!")
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with(" 1 - List all albums")
    expect(io).to receive(:puts).with("2 - List all artists")
    expect(io).to receive(:puts).and_return("Choise: 1 or 2?")
    expect(io).to receive(:gets).and_return("1")

    expect(io).to receive(:puts).with("Here is the list of albums:")

    expect(io).to receive(:puts).with(" * 1 - Doolittle")
    expect(io).to receive(:puts).with(" * 2 - Surfer Rosa")
    expect(io).to receive(:puts).with(" * 3 - Waterloo")
    expect(io).to receive(:puts).with(" * 4 - Super Trouper")
    expect(io).to receive(:puts).with(" * 5 - Bossanova")

    app.run

  end

  it "return artists when user chooses 2" do
    io = double :io
    albums = AlbumRepository.new
    artists = ArtistRepository.new 

    app = Application.new(data, io, albums, artists)

    expect(io).to receive(:puts).with("Welcome to the music library manager!")
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with(" 1 - List all albums")
    expect(io).to receive(:puts).with("2 - List all artists")
    expect(io).to receive(:puts).and_return("Choise: 1 or 2?")
    expect(io).to receive(:gets).and_return("2")

    expect(io).to receive(:puts).with("Here is the list of artists:")

    expect(io).to receive(:puts).with(" * 1 - Pixies")
    expect(io).to receive(:puts).with(" * 2 - ABBA")
    
    app.run

  end
end