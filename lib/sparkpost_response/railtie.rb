module SparkPostResponse
  class Railtie < Rails::Railtie
    initializer "sparkpost_response.add_core_ext" do
      Rails::Initializer.run do |config|
        config.load_paths << "core_ext"
      end
    end
    initializer "sparkpost_response.activesupport_extensions" do |_app|
      ActiveSupport::Base.send :extend, SparkpostResponse
    end
    config.after_initialize do
      require "sparkpost_response"
    end
  end
end
