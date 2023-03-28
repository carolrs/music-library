require 'album_repository'

RSpec.describe AlbumRepository do

  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_albums_table
  end

  it 'returns two albums' do
    repo = AlbumRepository.new
    albums = repo.all
    
    expected_result = Album.new("1", 'Patience', '1988', "1")

    expect(albums.length).to eq (2) # => 2

    expect(albums.first).to eq (expected_result) # => 'Patience'
    # expect(albums.first.release_year).to eq ('1988') # => '1988'
    # expect(albums.first.artist_id).to eq ('1') #=> 1

  end

end