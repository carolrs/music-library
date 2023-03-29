require 'artist_repository'

RSpec.describe ArtistRepository do

  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_albums_table
  end

  it 'return artist' do
    repo = ArtistRepository.new
    artists = repo.all
    
  
    expect(artists.first.name).to eq ('Guns n Roses')
    expect(artists.first.genre).to eq ('Rock')
  end

end