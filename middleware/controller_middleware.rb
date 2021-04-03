# frozen_string_literal: true

require_relative '../services/params_parser'
require_relative '../services/time_parser'
class ControllerMiddleware
  attr_accessor :params

  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
    @params = ParamsParser.parse(env['QUERY_STRING'])
    send(@app.route.action)
  end

  def time
    TimeParser.parse(params[:format])
  end
end
