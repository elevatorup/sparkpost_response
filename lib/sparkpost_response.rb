require "active_support/all"
require "active_record"
require "sparkpost_response"
require "sparkpost_response/sparkpost_base"
require "sparkpost_response/message_events"

module SparkpostResponse
  class << self
    attr_accessor :config

    def enabled=(value)
      configuration.enabled = value
    end

    def enabled?
      configuration.enabled
    end

    def configuration
      @config ||= Config.new
    end

    def configure
      @config ||= Config.new
      yield(configuration)
    end
  end

  class Config
    attr_accessor :api_key
    attr_accessor :enabled

    def initialize
      set_defaults
    end

    def enabled=(enable)
      @enabled = enable
    end


    def set_defaults
      @enabled = true
      @api_key = ENV.key?("SPARKPOST_API_KEY") ? ENV["SPARKPOST_API_KEY"] : ""
    end
  end
end
