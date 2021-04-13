require "sqlite3"
require "rack"
require "thin"
load "router.rb"

handler = Rack::Handler::Thin
handler.run(
  Router.new, 
  Port: 7373
)