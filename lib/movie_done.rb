class Movie

  # Class Variables

  # Hash of ALL movies where key is the movie id and the value is
  # a movie object
  @@movies = {}

  # Counter for the number of movies created.
  @@counter =  0

  # Instance Variables
  attr_accessor :title, :duration, :rating, :release_year, :id

  def initialize(m_title, m_duration, m_rating, m_release_year)
    @title = m_title
    @duration = m_duration
    @rating = m_rating
    @release_year = m_release_year
  end

  # Instance Methods
  def save
    Movie.add(self)
  end

  # Class Methods

  # Add a movie to the list of all movies.
  def Movie.add(movie)
    @@counter += 1
    # the movie id will be the counter value
    movie.id = @@counter
    # Add the movie to the list of all movies!
    @@movies[movie.id] = movie
  end

  # Get all movies.
  # This is a hash where each entry will have a key, movie.id, and value
  # that is the movie.
  def Movie.all
    @@movies
  end

  # Find a movie given it's id
  def Movie.find(id)
    @@movies[id]
  end
end
