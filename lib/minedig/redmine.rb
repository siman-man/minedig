# encoding: utf-8

module Minedig
  class Redmine
    attr_accessor :user_name, :path, :api_key, :root_path, :host
    attr_reader :home

    include Utilities

    def initialize
      if block_given?
        yield self
      end
    end

    # parse uri
    # @param uri redmine host uri
    def home=(uri)
      result = URI.parse(uri)
      @home = uri
      @host = result.host
      @root_path = result.path
    end

    # Get the ticket with specified id.
    # @param id ticket id.
    # @return [BasicObject] information of ticket.
    def ticket(id)
      raise 'ID has not been specified.' if id.nil?

      query = Minedig::Query::create(host: host, path: "/issues/#{id}.json",
                                      param: "include=journals")

      begin
        response = Minedig::Query::send(query: query, api_key: api_key)
        json = JSON.load(response.body)

        Minedig::Ticket.new(ticket: OpenStruct.new(json['issue']), host: host, api_key: api_key)
      rescue JSON::ParserError
        puts query
        puts "Ticket id:#{id} - #{response.message}"
      end
    end

    def tickets(count: 100)
      count = Float::INFINITY if count == :all
      result = []
      offset = 0

      while count > 0

        limit = [count, 100].min
        query = Minedig::Query::create(host: host, path: "/issues.json",
                                        param: "offset=#{offset}&limit=#{limit}&status_id=*")
        count -= limit
        offset += limit

        begin
          response = Minedig::Query::send(query: query, api_key: api_key)
          json = JSON.load(response.body)

          break if json['issues'].empty?

          json['issues'].each do |issue|
            result << Minedig::Ticket.new(ticket: OpenStruct.new(json['issue']), host: host, api_key: api_key)
          end

          sleep(1)
        rescue JSON::ParserError
          puts query
          puts "Ticket id:#{id} - #{response.message}"
        end
      end

      result
    end

    # return project list.
    # @return [Array] project list.
    def projects
      query = Minedig::Query::create(host: host, path: root_path + '/projects.json')
      response = Minedig::Query::send( query: query, api_key: api_key )
      json = JSON.load(response.body)
      projects = []

      json["projects"].each do |data|
        projects << OpenStruct.new(data)
      end

      projects
    end

    # return project info
    # @return project info
    def project(project_name)
      query = Minedig::Query::create(host: host, path: root_path + "/projects/#{project_name}.json")
      response = Minedig::Query::send(query: query, api_key: api_key )
      json = JSON.load(response.body)

      project = OpenStruct.new(json["project"])

      return Minedig::Project.new({
                                      id: project.id,
                                      name: project.name,
                                      root_path: root_path,
                                      path: root_path + "/projects/#{project.identifier}",
                                      host: host,
                                      api_key: api_key
                                  })
    end

    # Convert Hash to OpenStruct data.
    # @param data Hash data.
    # @return [OpenStruct] OpenStruct data.
    def hash2object(data)
      result = OpenStruct.new

      data.each do |key, value|
        if value.instance_of?(Hash)
          result[key] = hash2object(value)
        else
          result[key] = value
        end
      end

      result
    end
  end
end
