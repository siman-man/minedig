module Minedig
  module Query
    # Create a send query.
    # @param [String] host Redmine host URI.
    # @param [String] path path.
    # @param [String] param query parameter
    # return [String] new query
    def self.create(host: '', path: '', param: nil)
      if param.nil?
        URI::HTTP.build(host: host, path: path)
      else
        URI::HTTP.build(host: host, path: path, query: param)
      end
    end

    # Send to query.
    # @param [String] query send query
    # @param [String] api_key user's api key.
    # @param [Symbol] format
    # @param [Symbol] method
    def self.send(query: nil, api_key: nil, format: :json, method: :get, data: nil)
      Net::HTTP.start(query.host, query.port) do |http|
        case method
          when :get
            request = Net::HTTP::Get.new([query.path, query.query].join('?'))
          when :put
            request = Net::HTTP::Put.new([query.path, query.query].join('?'))
            request.body = data
        end

        request.set_content_type("application/#{format}")
        request["X-Redmine-API-Key"] = api_key

        response = http.request(request)
      end
    end
  end
end