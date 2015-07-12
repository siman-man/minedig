module Minedig
  class Project
    attr_reader :id, :name, :path, :root_path, :api_key, :host

    def initialize(id: nil, name: nil, path: '', root_path: '', api_key: '', host: '')
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
    def tickets(count: 100)
      count = Float::INFINITY if count == :all
      limit = [count, 100].min
      tickets = []
      offset = 0

      while count > 0
        query = Minedig::Query::create(host: host, path: root_path + '/issues.json',
                                       param: "offset=#{offset}&limit=#{limit}&project_id=#{id}")

        count -= limit
        offset += limit

        begin
          response = Minedig::Query::send(query: query, api_key: api_key)
          json = JSON.load(response.body)

          break if json['issues'].empty?

          json['issues'].each do |issue|
            tickets << Minedig::Ticket.new(ticket: OpenStruct.new(issue), host: host, api_key: api_key)
          end
        rescue => ex
          puts query
          puts ex.message
        end
      end

      tickets
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
