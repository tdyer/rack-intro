# Ruby Rack

In the words of the author of Rack – Christian Neukirchen: 

_Rack aims to provide a minimal API for connecting web servers supporting Ruby (like WEBrick, Mongrel etc.) and Ruby web frameworks (like Rails, Sinatra etc.)._

Ruby Web frameworks, (Rails, ...), are built on top of Rack. 


# Objectives

* View the environment variable Hash created for a HTTP Request.
* Build a mimimal Ruby Web application using Rack.


## We Do 

Install the Ruby Gems listed in the Gemfile.

```bash
$ bundle install
```

Let's build a small Rack Application.

Create a file **movies_app.rb**

```ruby
# Allow this Ruby file to use Ruby Gems.
require 'rubygems'
# Use the Rack Ruby Gem
require 'rack'

# Create a Ruby class with a "call" method
# Rack will invoke this "call" method.
class MoviesApp

  # This 'call' method gets invoked when the HTTP Server
  # recieves a HTTP Request
  def call(env)
    # The env parameter, which is a Ruby Hash, holds info from the HTTP Request


    # Let create a HTML page showing all the info in the env parameter
    content = '<html><head><title>HTTP Info</title></head><body><ul>'

    env.each do |key, value|
      content << "<li>#{key} is #{value} </li>"
    end
    content += '</ul></body></html>'

    # [HTTP Status, Mime-Type, Request Body]
    [200, {"Content-Type" => "text/html" }, [content] ]
  end
end

# Tell Rack to use the Ruby WEBrick HTTP Server 
# and listen to HTTP Requests on port 3000.
Rack::Handler::WEBrick.run(MoviesApp.new, Port: 3000)

```

Run this Web Application.

```bash
$ ruby movies_app.rb
```

In the Browser go to `http://localhost:3000/movies`

Using the Chrome Inspector view the source code, HTML, returned by our application.

_Notice that this is exactly the HTML that we built dynamically in our app._

Dynamic Content is typically built from inside our web application. Usually, the content is HTML and is based on data that is stored in a Database. 

_We'll see this later when we use RubyOnRails._

## Use a Ruby Class for Movies.

Let's create a Movie Ruby class that we'll use in our Web Application in **lib/movie.rb**.

```ruby
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
end

```

Let's create a couple of Movie objects, in **lib/init_app.rb**

```ruby
require_relative 'movie_done'

# Create 3 movies
movie1 = Movie.new('Room', 123, 'R', 2015)
movie2 = Movie.new('Jaws', 136, 'PG', 1977)
movie3 = Movie.new('Wizard of Oz', 176, 'G', 1939)

# Add each Movie to the list of Movies
Movie.add(movie1)
Movie.add(movie2)
Movie.add(movie3)

```

Let's use this Movie class in our Web application. Change **movies_app.rb**.

```ruby
...
# Add file to initialize the app's movies.
require_relative 'lib/init_app_done'

...

# Add code to be executed when we access the path /movies
if(env['REQUEST_PATH'] == '/movies')
      Movie.all.each do |id, movie|
        content << "<li>#{movie.title} was released in #{movie.release_year} </li>"
      end
    content += '</ul></body></html>'
end
```

## Find a specific Movie by Id

Add the below class method to the lib/movie.rb file.

```ruby
 # Find a movie given it's id                                                  
  def Movie.find(id)
    @@movies[id]
  end
```

Add the below code to the application, movie_app.rb.

```ruby
...
# See if the PATH matches a URL with /movies/3
elsif(env['REQUEST_PATH'] =~ /\/movies\/\d+/)
      id = env['REQUEST_PATH'].split('/')[2]
      puts "id is #{id}"
      movie = Movie.find(id.to_i)
      puts "id is #{id}"
      content << "<li>#{movie.title} was released in #{movie.release_year} </li\

...      
>"

```
