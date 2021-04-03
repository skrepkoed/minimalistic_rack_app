# frozen_string_literal: true

class ParamsParser
  def self.parse(querry_string)
    querry_string.split('&').map do |pair|
      pair = pair.split('=')
      pair[0] = pair[0].to_sym
      pair[1] = pair[1].delete("'")
      pair
    end.to_h
  end
end
