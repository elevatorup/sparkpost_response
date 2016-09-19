require "sparkpost_response"
require "codeclimate-test-reporter"
require "webmock/rspec"

CodeClimate::TestReporter.start

Dir["./spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.before(:each) do
    SparkpostResponse.configure do |c|
      c.api_key = "TESTKEY1234"
    end
  end
end
