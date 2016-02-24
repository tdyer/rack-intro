require_relative 'movie_done'

# Create 3 movies
movie1 = Movie.new('Room', 123, 'R', 2015)
movie2 = Movie.new('Jaws', 136, 'PG', 1977)
movie3 = Movie.new('Wizard of Oz', 176, 'G', 1939)

# Add each Movie to the list of Movies
Movie.add(movie1)
Movie.add(movie2)
Movie.add(movie3)
