# allow this ruby file to use ruby gems
require 'rubygems'

# Use the Ruby Rack Gem
require 'rack'
require_relative 'lib/init_app.rb'

# Create a Ruby class with a "call" method
class MoviesApp

  # This method gets invoked when WEBrick recieves a
  # HTTP Request.
  # call is a special method that Rack will use.
  # env - Ruby Hash that contain lots of info
  # about the HTTP Request
  def call(env)

    # building the HTML to send back to the browser

   # Let create a HTML page showing all the info in the env parameter
    content = '<html><head><title>HTTP Info</title></head><body><ul>'


    if(env['REQUEST_PATH'] == '/movies')
      # http://localhost:3000/movies
      Movie.all.each do |id, movie|
        content << "<li>#{movie.title} was released in #{movie.release_year}</li>"
      end
    end
    content += '</ul></body></html>'

    # [HTTP Status, HTTP Response Header, HTTP Response body]
    # [Fixnum, Hash, Array]
    [200, {"Content-Type" => "text/html"}, [content]]
  end
end

# Use Rack to connect this web app with a HTTP Server
# Connect with the WEBrick HTTP Server
Rack::Handler::WEBrick.run(MoviesApp.new, Port: 3000)
