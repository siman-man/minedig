module Redmine
  module Query
    Dotenv.load

    # 送信するクエリの作成
    # @param [String] host 送信先のRedmineホスト URL.
    # @param [String] path 対象のプロジェクト
    # @param [String] method クエリの種類
    # return [String] 生成されたクエリ文
    def self.create( host: nil, path: '', method: '' )
      URI::HTTP.build( host: host, path: path + method )
    end

    # クエリの送信を行う
    # @param [String] query 送信するquery
    #　@param [String] api_key ユーザのAPIKEY
    # @param [String] type 取得するデータのタイプ(デフォルトはjson形式)
    def self.send(query: nil, api_key: nil, type: :json)
      Net::HTTP.start(query.host, query.port) do |http|

        request = Net::HTTP::Get.new(query.path)

        request.set_content_type("application/#{type}")
        request["X-Redmine-API-Key"] = api_key

        response = http.request(request)
      end
    end
  end
end