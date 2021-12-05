# frozen_string_literal: true

# Log Class
class Log
  attr_reader :url, :ip

  def initialize(url, ip)
    @url = url
    @ip = ip
  end
end
