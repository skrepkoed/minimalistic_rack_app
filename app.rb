# frozen_string_literal: true

require 'pry'
class App
  def call(_env)
    response = Rack::Response.new
    text_plain(response)
    response
  end

  private

  def text_plain(response)
    response['Content-Type'] = 'text/plain'
  end
end
