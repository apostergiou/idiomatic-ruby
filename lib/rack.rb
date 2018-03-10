require 'rack'

# A simple rack example
class HelloWorldApp
  def self.call(env)
    # 200 is the HTTP status code
    # the second element is the response HTTP header hash
    # finally the last element is the response body
    ['200', {'Content-Type' => 'text/html'}, ['A hello world rack app.']]
  end
end

class AddSomeHeaders
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env).tap { |status, headers, body| headers['X-awesome'] = true }
  end
end

class EditSomeHeaders
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env).tap do |status, headers, body|
      headers.delete('X-awesome')
      headers['X-double-awesome'] = 'true'
    end
  end
end

app = Rack::Builder.new do
  use EditSomeHeaders
  use AddSomeHeaders
  run HelloWorldApp
end

Rack::Handler::WEBrick.run app
