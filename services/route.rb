class Route
	attr_reader :http_method, :route, :action
	@@routes = [{'/' => :get}, {'/time' => :get}]
	def initialize(http_method:,route:)
		@http_method = http_method.downcase.to_sym
		@route = route
		@action = @route.action
	end

	def action
		case route
		when '/' then :hello
		when '/time' then :time
		end
	end

	def exists?
		@@routes.include?({route => http_method})
	end
end