require 'cgi'
class TimeParser
  attr_reader :time_format, :time, :unknown_formats

  ALLOWED_FORMATS = { 'second' => '%S', 'minute' => '%M', 'hour' => '%H', 'day' => '%d', 'month' => '%m',
                      'year' => '%Y' }.freeze

  def initialize(time_format)
    @time_format = CGI.unescape(time_format).split(',')
    @time = Time.now
    analyze
  end

  def formated_time
    time.strftime(@directives)
  end

  def analyze
    @directives = ''
    @unknown_formats = []
    time_format.each do |format|
      if ALLOWED_FORMATS[format]
        @directives += "#{ALLOWED_FORMATS[format]}:"
      else
        unknown_formats << format
      end
    end
    @directives.chop!
  end

  def success?
    unknown_formats.empty?
  end
end
