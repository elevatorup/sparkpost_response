require "sparkpost_response"
require "codeclimate-test-reporter"
require "webmock/rspec"

require "factory_girl"

CodeClimate::TestReporter.start

Dir["./spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:each) do
    SparkpostResponse.configure do |c|
      c.api_key = "TESTKEY1234"
    end
  end

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end
