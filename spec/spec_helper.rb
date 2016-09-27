require "sparkpost_response"
require "codeclimate-test-reporter"
require "webmock/rspec"
require "rspec/core"
require "rspec/matchers"

CodeClimate::TestReporter.start

Dir["./spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.before(:each) do
    SparkpostResponse.configure do |c|
      c.api_key = "TESTKEY1234"
      c.enabled = true
    end
  end
end
