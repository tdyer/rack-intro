class Movie

  # Class variables

  # Hash of ALL Movies.
  @@movies = {} # start with an empty hash

  # Counter for the number of movies created
  @@counter = 0 # initialized with the value of zero

  # Instance Variables
  attr_accessor :title, :duration, :rating, :release_year, :id

  # method that gets called when we create a new
  # movie, Movie.new(...) this method is called.
  def initialize(m_title, m_duration, m_rating, m_release_year)
    # set all our instance variable for this new
    # object.
    @title = m_title
    @duration = m_duration
    @rating = m_rating
    @release_year = m_release_year
  end

  # save this movie
  def save
    # Later!!!
    Movie.add(self)
  end

  # Class Methods

  # Add a movie to the list of all movies
  def Movie.add(movie)
    # increment the class variable counter by 1
    @@counter += 1

    movie.id = @@counter

    # Add the movie to the list of movies
    # movie.id : 1, movie : title: 'Room', ....
    # movie.id : 2, movie : title: 'Jaws', ....
    @@movies[movie.id] = movie
  end

  # Get all the movies
  def Movie.all
    @@movies
  end
end
