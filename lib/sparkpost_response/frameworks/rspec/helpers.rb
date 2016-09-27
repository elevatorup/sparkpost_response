module SparkpostResponse
  module RSpec
    module Helpers
      module InstanceMethods
        def with_sparkpost
          was_enabled = ::SparkpostResponse.enabled?
          ::SparkpostResponse.enabled = true
          yield
        ensure
          ::SparkpostResponse.enabled = was_enabled
        end
      end
    end
  end
end
