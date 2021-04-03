require_relative 'app'
require_relative 'middleware/routes_middleware'
use RoutesMiddleware
run App.new