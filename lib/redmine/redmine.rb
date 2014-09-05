# encoding: utf-8

module Minedig
  class Redmine
    attr_accessor :user_name, :host, :path, :api_key

    include Query
  
    def initialize
      if block_given?
        yield self
      end
    end

    # 指定されたidからプロジェクト検索し、そのプロジェクトを返す。
    def project(id)
      projects.each do |project|
        if project.id == id || project.name == id || project.identifier == id
          return Minedig::Project.new({
                    id: project.id, 
                  name: project.name, 
            identifier: '/projects/' + project.identifier,
                  host: host,
              api_key: api_key 
            })
        end
      end

      raise "Not found Project."
    end

    # プロジェクトの一覧を返す。
    # @return [Array] プロジェクトの一覧
    def projects
      query = Query::create( host: host, method: '/projects.json' )
      response = Query::send( query: query, api_key: api_key )
      json = JSON.load(response.body)
      projects = []

      json["projects"].each do |data|
        projects << OpenStruct.new(data)
      end

      projects
    end

    # HashをOpenStructのオブジェクトへ変換を行う。
    # @param data ハッシュデータ
    # @return [OpenStruct] 変換したオブジェクトデータ
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