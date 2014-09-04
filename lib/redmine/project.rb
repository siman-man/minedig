module Redmine
  class Project
    include Query
    include Members
    include Issues

    attr_accessor :user_name, :redmine_host, :path, :api_key
    
    def initialize
      if block_given?
        yield self
      end
    end

    def ticket_list
      Redmine::Ticket.list
    end

    def member_list
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