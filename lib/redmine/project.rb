# encoding: utf-8

class Project < Redmine
  attr_reader :id, :name, :identifier, :api_key

  def initialize( id: id, name: name, identifier: identifier, api_key: api_key )
    @id = id
    @name = name
    @identifier = identifier
    @api_key = api_key
  end

    # チケットの一覧を獲得する
    # @return [Array] チケット一覧
    def ticket_list
      Redmine::Ticket.list
    end

    # 指定したIDのチケットの取得を行う。
    # @param id チケットのID
    # @return [BasicObject] チケット情報
    def ticket(id)
      raise "IDが指定されていません。" if id.nil?

      query = Query::create( host: redmine_host, method: "/issues/#{id}.json" )

      begin
        response = Query::send( query: query, api_key: api_key )
        json = JSON.load(response.body)
        
        Ticket.new(OpenStruct.new(json['issue']))
      rescue JSON::ParserError
        puts query
        puts "Ticket id:#{id} - #{response.message}"
      end
    end

    def user_list
      User.list( host: host, identifier: identifier )
    end
  end