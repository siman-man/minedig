module Redmine
  module Issues
    def issue_list
      query = Query::create( path: path, method: '/issues.json' )
      response = Query::send( query: query, api_key: api_key )
      json = JSON.load(response.body)
      issues = []

      json["issues"].each do |data|
        issues << Redmine::hash2object(data)
      end

      issues
    end
  end
end