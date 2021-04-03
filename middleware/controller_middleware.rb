require_relative '../services/params_parser'
require_relative '../services/time_parser'
require 'pry'
class ControllerMiddleware
	attr_accessor :params
	def initialize(app)
		@app = app
	end

	def call(env)
		status, headers, body = @app.call(env)
		@params = ParamsParser.parse(env["QUERY_STRING"])
		send(@app.route.action)
		[status, headers, body]
	end

	def time
	end
end