module SparkpostResponse
  class MessageEvents < SparkpostBase
    include ::ActiveModel::AttributeMethods
    attr_accessor :name

    attr_accessor :api_method
    attribute_method_suffix "_messages_event"
    define_attribute_methods %w(delivery injection bounce delay policy_rejection out_of_band
                                open click generation_failure generation_rejection spam_complaint
                                list_unsubscribe link_unsubscribe)

    def initialize
      @api_method = "message_events"
      prepare_api_headers
    end

    def attribute_messages_event(attribute, options = {})
      messages_event({ events: attribute }.merge(options))
    end

    def messages_event(options = {})
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
