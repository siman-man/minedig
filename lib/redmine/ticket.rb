module Redmine

  # Redmineのチケットに関する処理をまとめたもの
  class Ticket
    class << Ticket
      
      # チケット一覧を取得する
      # @return [Array] 取得したチケットの一覧
      def list
        query = Query::create( host: redmine_host, path: path, method: '/issues.json' )
        response = Query::send( query: query, api_key: api_key )
        json = JSON.load(response.body)
        tickets = []

        json["issues"].each do |data|
          tickets << Redmine::hash2object(data)
        end

        tickets
      end

      # 指定したチケットの取得を行う
      # @param id 取得するチケットのID
      # @return [BasictObject] 取得したチケットの情報
      def self.find( id, type: :json )
        raise "IDが指定されていません。" if id.nil?

        query = Query::create( host: redmine_host, path: 'issues', method: "/#{id}.#{type.to_s}" )
        response = Query::send( query: query, api_key: api_key )

        ticket = JSON.load(response.body)

        ticket
      end
    end
  end
end