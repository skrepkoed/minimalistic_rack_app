# frozen_string_literal: true

class Route
  attr_reader :http_method, :route, :action

  ROUTES = [{ '/' => :get }, { '/time' => :get }]
  def initialize(http_method:, route:)
    @http_method = http_method.downcase.to_sym
    @route = route
    @action = define_action
  end

  def define_action
    case route
    when '/' then :hello
    when '/time' then :time
    end
  end

  def exists?
    ROUTES.include?({ route => http_method })
  end
end
