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


