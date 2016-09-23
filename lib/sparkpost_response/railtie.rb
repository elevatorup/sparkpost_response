module SparkPostResponse
  class Railtie < Rails::Railtie
    initializer "sparkpost_response.add_core_ext" do
      Rails::Initializer.run do |config|
        config.load_paths << "core_ext"
      end
    end
    config.after_initialize do
      require "sparkpost_response"
    end
  end
end
