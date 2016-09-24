require "sparkpost_response/frameworks/rspec/helpers"

RSpec.configure do |config|
  config.include ::SparkpostResponse::RSpec::Helpers::InstanceMethods

  config.before(:each) do
    ::SparkpostResponse.enabled = false
  end
end
