class Album
  attr_accessor :id, :title, :release_year, :artist_id

  def initialize(id = nil, title = nil, release_year = nil, artist_id = nil)
    @id = id
    @title = title
    @release_year = release_year
    @artist_id = artist_id
  end

  def ==(other)
    return false unless other.is_a?(Album)
    @id == other.id && @title == other.title && @release_year == other.release_year && @artist_id == other.artist_id
  end

end