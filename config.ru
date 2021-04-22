require "pry"
require "sqlite3"
require "rack"
require "rack/cors"
require "thin"
load "router.rb"

use Rack::Cors do
  allow do
    origins '*'

    resource '*'
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end


handler = Rack::Handler::Thin
handler.run(
  Router.new, 
  Port: 7373
)