# encoding: utf-8

module Minedig
  class Redmine
    attr_accessor :user_name, :host, :path, :api_key

    def initialize
      if block_given?
        yield self
      end
    end

    # search project。
    def project(id)
      projects.each do |project|
        if project.id == id || project.name == id || project.identifier == id
          return Minedig::Project.new({
            id: project.id, 
            name: project.name, 
            path: "/projects/#{project.identifier}",
            host: host,
            api_key: api_key 
          })
        end
      end

      raise 'Not found Project.'
    end

    # return project list.
    # @return [Array] project list.
    def projects
      query = Minedig::Query::create( host: host, path: '/projects.json' )
      response = Minedig::Query::send( query: query, api_key: api_key )
      json = JSON.load(response.body)
      projects = []

      json["projects"].each do |data|
        projects << OpenStruct.new(data)
      end

      projects
    end

    # Convert Hash to OpenStruct data.
    # @param data Hash data.
    # @return [OpenStruct] OpenStruct data.
    def self.hash2object(data)
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