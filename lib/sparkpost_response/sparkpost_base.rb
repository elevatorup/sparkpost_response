module SparkpostResponse
  class SparkpostBase
    require "net/http"

    attr_accessor :response, :headers

    protected

    def process_response(results)
      result_data = JSON.parse(results.body).with_indifferent_access

      if result_data[:errors]
        @response = result_data[:errors]
        raise @response
      else
        @response = result_data[:results]
      end
    end

    def get_to_api(options)
      url = "https://api.sparkpost.com/api/v1/#{@api_method}?#{options}"

      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri.request_uri, @headers)
      http.request(request)
    end

    def prepare_api_headers
      @headers = {
        "Authorization" => SparkpostResponse.configuration.api_key,
        "Content-Type" => "application/json",
      }
    end
  end
end
