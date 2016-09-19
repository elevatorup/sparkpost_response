module SparkpostResponse
  class MessageEvents < SparkpostBase
    attr_accessor :api_method

    def initialize
      @api_method = "message_events"
      prepare_api_headers
    end

    def bounced_event_messages(options = {})
      event_messages({ events: "bounced" }.merge(options))
    end

    def delivery_event_messages(options = {})
      event_messages({ events: "delivery" }.merge(options))
    end

    def event_messages(options = {})
      opts = process_options(options)
      response = get_to_api(opts)
      process_response(response)
    end

    def process_options(options = {})
      options.map do |key, value|
        value.is_a?(Array) ? ["#{key}=#{value.join(',')}"] : ["#{key}=#{value}"]
      end.join("&")
    end
  end
end
