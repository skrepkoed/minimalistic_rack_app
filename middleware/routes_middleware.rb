# frozen_string_literal: true

require_relative '../services/route'
class RoutesMiddleware
  attr_reader :route

  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    @route = Route.new(http_method: env['REQUEST_METHOD'], route: env['REQUEST_PATH'])
    unless route.exists?
      status = '404'
      body = ['Not found']
    end
    [status, headers, body]
  end
end
