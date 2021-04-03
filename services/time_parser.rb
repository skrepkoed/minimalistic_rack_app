# frozen_string_literal: true

require 'cgi'
class TimeParser
  ALLOWED_FORMATS = { 'second' => '%S', 'minute' => '%M', 'hour' => '%H', 'day' => '%d', 'month' => '%m',
                      'year' => '%Y' }.freeze
  attr_accessor :time

  def self.parse(time_format)
    time = Time.now
    time_format = CGI.unescape(time_format).split(',')
    directives = ''
    unknown_formats = []
    time_format.each do |format|
      if ALLOWED_FORMATS[format]
        directives += "#{ALLOWED_FORMATS[format]}:"
      else
        unknown_formats << format
      end
    end
    directives.chop!
    if unknown_formats.empty?
      [200, { 'Content-Type' => 'text/plain' }, [time.strftime(directives)]]
    else
      [400, { 'Content-Type' => 'text/plain' }, ["Unknown time format #{unknown_formats}"]]
    end
  end
end
