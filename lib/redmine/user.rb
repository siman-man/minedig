 module Redmine
  class User 
    class << User
      # メンバーの一覧を取得する
      # @return [Array] メンバー情報
      def list
        query = Query::create( path: path, method: '/memberships.json' )
        response = Query::send( query: query, api_key: api_key )
        json = JSON.load(response.body)
        users = []

        json["memberships"].each do |data|
          if data["user"]
            users << OpenStruct.new(data["user"])
          end
        end

        users
      end
    end
  end
end