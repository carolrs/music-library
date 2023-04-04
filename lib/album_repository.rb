require_relative 'album'

class AlbumRepository
  def all 
    albums = []

    sql = 'SELECT id, title, release_year, artist_id FROM albums;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      album.artist_id = record['artist_id']

      albums << album
    end

    return albums
  end
  def find(id)

    sql = 'SELECT id, title, release_year, artist_id FROM albums Where id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])

    record = result_set[0]

      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      album.artist_id = record['artist_id']

      return album

  end
  def create(album)
    sql = 'INSERT INTO albums(title, release_year, artist_id) VALUES ($1, $2, $3)'
    DatabaseConnection.exec_params(sql, [album.title, album.release_year, album.artist_id])

    return album
  end
end