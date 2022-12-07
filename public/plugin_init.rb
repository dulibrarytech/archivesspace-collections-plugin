require "net/http"
require "uri"

Plugins::extend_aspace_routes(File.join(File.dirname(__FILE__), "routes.rb"))
