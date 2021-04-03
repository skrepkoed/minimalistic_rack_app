class Route
	attr_reader :http_method, :route
	@@routes = [{'/' => :get}, {'/time' => :get}]
	def initialize(http_method:,route:)
		@http_method = http_method.downcase.to_sym
		@route = route
	end

	def exists?
		@@routes.include?({route => http_method})
	end
end