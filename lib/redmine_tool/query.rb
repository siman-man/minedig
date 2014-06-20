module RedmineTool
  module Query
    Dotenv.load

    def self.create( host: nil, path: nil, method: nil )
      URI::HTTP.build( host: host, path: path + method )
    end

    def self.send(uri: nil, api_key: nil, type: :json)
      Net::HTTP.start(uri.host, uri.port) do |http|

        request = Net::HTTP::Get.new(uri.path)

        request.set_content_type("application/#{type}")
        request["X-Redmine-API-Key"] = api_key

        response = http.request(request)
      end
    end
  end
end