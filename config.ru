# frozen_string_literal: true

require_relative 'app'
require_relative 'middleware/routes_middleware'
require_relative 'middleware/controller_middleware'
use ControllerMiddleware
use RoutesMiddleware
run App.new
