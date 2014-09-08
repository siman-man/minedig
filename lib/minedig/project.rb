# encoding: utf-8

module Minedig
  class Project
    attr_reader :id, :name, :path, :root_path, :api_key, :host

    def initialize( id: nil, name: nil, path: '', root_path: '', api_key: '', host: '' )
      @id = id
      @name = name
      @path = path
      @root_path = root_path
      @api_key = api_key
      @host = host
    end

    # Get ticket list.
    # @return [Array] ticket list.
    def ticket_list
      Minedig::Ticket.list
    end

    # Get project ticket list.
    # @return [Array] ticket information.
    def tickets
      query = Minedig::Query::create( host: host, path: root_path + '/issues.json', param: "project_id=#{id}" )
      p query

      begin
        response = Minedig::Query::send( query: query, api_key: api_key )
        json = JSON.load(response.body)
        tickets = []

        json['issues'].each do |issue|
          tickets << Minedig::Ticket.new(OpenStruct.new(issue))
        end

        tickets
      rescue => ex
        puts ex.message
      end
    end

    # Get member list.
    # @return [Array] member information.
    def user_list
      query = Minedig::Query::create( host: host, path: "#{path}/memberships.json" )
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
