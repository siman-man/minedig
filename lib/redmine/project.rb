class Redmine
  class Project
    attr_reader :id, :name, :identifier

    def initialize( id: id, name: name, identifier: identifier )
      @id = id
      @name = name
      @identifier = identifier
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
      Redmine::User.list( host: redmine_host, path: path )
    end
  end
end