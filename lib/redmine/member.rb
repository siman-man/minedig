 module Redmine
  class Member 
    class << Member
      # メンバーの一覧を取得する
      # @return [Array] メンバー情報
      def list
        query = Query::create( path: path, method: '/memberships.json' )
        response = Query::send( query: query, api_key: api_key )
        json = JSON.load(response.body)
        members = []

        json["memberships"].each do |data|
          if data["user"]
            members << OpenStruct.new(data["user"])
          end
        end

        members
      end
    end
  end
end