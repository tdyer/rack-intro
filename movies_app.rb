require 'rubygems'
require 'rack'

# Simple Rack Application
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

Rack::Handler::WEBrick.run(MoviesApp.new, Port: 3000)
