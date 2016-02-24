require 'rubygems'
require 'rack'
require 'pry'

require_relative 'lib/init_app_done'

# Simple Rack Application
class MoviesApp

  # This 'call' method gets invoked when the HTTP Server
  # recieves a HTTP Request
  def call(env)
    # Let create a HTML page showing all the movies
    content = '<html><head><title>Favorite Movies</title></head><body><ul>'

    # binding.pry
    if(env['REQUEST_PATH'] == '/movies')
      Movie.all.each do |id, movie|
        content << "<li>#{movie.title} with id #{movie.id} was released in #{movie.release_year} </li>"
      end
    elsif(env['REQUEST_PATH'] =~ /\/movies\/\d+/)
      id = env['REQUEST_PATH'].split('/')[2]
      puts "id is #{id}"
      movie = Movie.find(id.to_i)
      puts "id is #{id}"
      content << "<li>#{movie.title} was released in #{movie.release_year} </li>"
    end

    content += '</ul></body></html>'

    # [HTTP Status, Mime-Type, Request Body]
    [200, {"Content-Type" => "text/html" }, [content] ]
  end
end

Rack::Handler::WEBrick.run(MoviesApp.new, Port: 3000)
