require_relative '../services/params_parser'
require_relative '../services/time_parser'
require_relative '../services/route'
class TimeMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    route = Route.new(http_method: env['REQUEST_METHOD'], route: env['REQUEST_PATH'])
    @response = @app.call(env)
    if route.exists?
      send(route.action, ParamsParser.parse(env['QUERY_STRING']))
    else
      not_found
    end
    @response.finish
  end

  def time(params)
    bad_request
    if params[:format]
      time = TimeParser.new(params[:format])
      if time.success?
        success(time)
      else
        unknown_time_format(time)
      end
    end
  end

  def bad_request
    @response.status = 400
    @response.body = ['Bad Request']
  end

  def success(time)
    @response.status = 200
    @response.body = [time.formated_time]
  end

  def unknown_time_format(time)
    @response.body << verbose_unknown_formats(time)
  end

  def verbose_unknown_formats(time)
    "\nUnknown time formats: #{time.unknown_formats}"
  end

  def not_found
    @response.status = 404
    @response.body = ['Not Found']
  end

  def hello
    @response.body = ['Hello!']
  end
end
