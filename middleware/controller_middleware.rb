# frozen_string_literal: true

require_relative '../services/params_parser'
require_relative '../services/time_parser'
class ControllerMiddleware
  attr_accessor :params

  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    @params = ParamsParser.parse(env['QUERY_STRING'])
    if @app.route.exists?
      send(@app.route.action)
    else
      [404, { 'Content-Type' => 'text/plain' }, ['Not Found']]
    end
  end

  def time
    TimeParser.parse(params[:format])
  end

  def hello
    [200, { 'Content-Type' => 'text/plain' }, ['Hello!']]
  end
end
