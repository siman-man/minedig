# encoding: utf-8

module Minedig
  class Project
    attr_reader :id, :name, :identifier, :api_key, :host

    def initialize( id: nil, name: nil, identifier: nil, api_key: nil, host: nil )
      @id = id
      @name = name
      @identifier = identifier
      @api_key = api_key
      @host = host
    end

    # チケットの一覧を獲得する
    # @return [Array] チケット一覧
    def ticket_list
      Minedig::Ticket.list
    end

    # 指定したIDのチケットの取得を行う。
    # @param id チケットのID
    # @return [BasicObject] チケット情報
    def ticket(id)
      raise "IDが指定されていません。" if id.nil?

      query = Minedig::Query::create( host: host, method: "/issues/#{id}.json" )

      begin
        response = Minedig::Query::send( query: query, api_key: api_key )
        json = JSON.load(response.body)
        
        Minedig::Ticket.new(OpenStruct.new(json['issue']))
      rescue JSON::ParserError
        puts query
        puts "Ticket id:#{id} - #{response.message}"
      end
    end

    # メンバーの一覧を取得する
    # @return [Array] メンバー情報
    def user_list
      query = Minedig::Query::create( host: host, identifier: identifier, method: '/memberships.json' )
      response = Minedig::Query::send( query: query, api_key: api_key )
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