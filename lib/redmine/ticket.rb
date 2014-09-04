module Redmine
  # Redmineのチケットに関する処理をまとめたもの
  class Ticket
    attr_reader :ticket

    class << Ticket
      # チケット一覧を取得する
      # @return [Array] 取得したチケットの一覧
      def list
        query = Query::create( path: path, method: '/issues.json' )
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

        query = Query::create( path: 'issues', method: "/#{id}.#{type.to_s}" )
        response = Query::send( query: query, api_key: api_key )

        ticket = JSON.load(response.body)

        ticket
      end
    end

    def initialize(ticket = nilra)
      @ticket = ticket
    end

    # チケットが持っているプロパティの一覧を取得する
    # @return [Array] チケットのプロパティ一覧
    def properties
      ticket.singleton_methods
    end

    def status
      ticket.status["name"]
    end

    def status_id
      ticket.status["id"]
    end

    def project
      ticket.project["name"]
    end

    def project_id
      ticket.project["id"]
    end

    def priority
      ticket.priority["name"]
    end

    def priority_id
      ticket.priority["id"]
    end

    def method_missing( name, *args )
      if ticket.respond_to?(name)
        ticket[name]
      else
        super
      end
    end
  end
end