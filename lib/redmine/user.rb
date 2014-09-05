# encoding: utf-8

class User < Project
  class << User
    # メンバーの一覧を取得する
    # @return [Array] メンバー情報
    def list
      query = Redmine::Query::create( host: host, identifier: identifier, method: '/memberships.json' )
      response = Redmine::Query::send( query: query, api_key: api_key )
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