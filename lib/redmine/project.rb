module Redmine
  class Project
    include Query

    attr_accessor :user_name, :redmine_host, :path, :api_key
    
    def initialize
      if block_given?
        yield self
      end
    end

    def list
      query = Query::create( host: redmine_host, method: '/projects.json' )
      response = Query::send( query: query, api_key: api_key )
      json = JSON.load(response.body)
      projects = []

      json["projects"].each do |data|
        projects << OpenStruct.new(data)
      end

      projects
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

    def member_list
      query = Query::create( host: redmine_host, path: path, method: '/memberships.json' )
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