module SparkpostResponse
  # https://support.sparkpost.com/customer/portal/articles/1929896
  BOUNCE_CLASS = { undetermined: { level: :undetermined, code: 1 },
                   invalid_recipient: { level: :hard, code: 10 },
                   soft_bounce: { level: :soft, code: 20 },
                   dns_failure: { level: :soft, code: 21 },
                   mailbox_full: { level: :soft, code: 22 },
                   too_large: { level: :soft, code: 23 },
                   timeout: { level: :soft, code: 24 },
                   admin_failure: { level: :admin, code: 25 },
                   no_rcpt: { level: :hard, code: 30 },
                   generic_bounce: { level: :soft, code: 40 },
                   mail_block: { level: :block, code: 50 },
                   spam_block: { level: :block, code: 51 },
                   spam_content: { level: :block, code: 52 },
                   prohibited_attachment: { level: :block, code: 53 },
                   relaying_denied: { level: :block, code: 54 },
                   auto_reply: { level: :soft, code: 60 },
                   transient_failure: { level: :soft, code: 70 },
                   subscribe: { level: :admin, code: 80 },
                   unsubscribe: { level: :hard, code: 90 },
                   challenge_response: { level: :soft, code: 100 } }.freeze

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
      bounce_classify = false

      if options[:classify_bounces]
        bounce_classify = options[:classify_bounces]
        options.delete(:classify_bounces)
      end

      opts = process_options(options)
      response = get_to_api(opts)
      data_return = process_response(response)
      bounce_classify ? classify_bounces(data_return) : data_return
    end

    def process_options(options = {})
      options.map do |key, value|
        value.is_a?(Array) ? ["#{key}=#{value.join(',')}"] : ["#{key}=#{value}"]
      end.join("&")
    end

    # Inserts an entry into the bounce responses with meta information about the bounced error
    def classify_bounces(responses)
      responses.each do |message|
        if message[:type] == "bounce"
          message[:classify_bounce] = error_by_code(message[:bounce_class].to_i)
        end
      end
    end

    # Select the error from the list of possible codes
    def error_by_code(code)
      BOUNCE_CLASS.detect { |_, bounce| bounce[:code] == code }
    end
  end
end
