require_relative '../services/params_parser'
require_relative '../services/time_parser'
require_relative '../services/route'
class TimeMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    @response = @app.call(env)
    if env['REQUEST_PATH'] == '/time' && env['REQUEST_METHOD'] == 'GET'
      time(ParamsParser.parse(env['QUERY_STRING']))
    else
      make_responce(404, 'Not Found')
    end
    @response.finish
  end

  def time(params)
    time = TimeParser.new(params[:format])
    time.analyze
    if time.success?
      make_responce(200, time.formated_time)
    else
      unknown_time_format(time)
    end
  end

  def make_responce(status, body)
    @response.status = status
    @response.body = [body]
  end

  def unknown_time_format(time)
    make_responce(400, 'Bad Request')
    @response.body << verbose_unknown_formats(time)
  end

  def verbose_unknown_formats(time)
    "\nUnknown time formats: #{time.unknown_formats}"
  end
end
