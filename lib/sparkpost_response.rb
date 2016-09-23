require "active_support/all"
require "active_record"
require "sparkpost_response/sparkpost_base"
require "sparkpost_response/message_events"

require "sparkpost_response/railtie" if defined? ::Rails

module SparkpostResponse
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :api_key

    def initialize
      set_defaults
    end

    def set_defaults
      @api_key = ENV.key?("SPARKPOST_API_KEY") ? ENV["SPARKPOST_API_KEY"] : ""
    end
  end
end
