module RedmineTool
  module Issues
    def issue_list
      uri = Query::create( host: redmine_host, path: path, method: '/issues.json' )
      response = Query::send( uri: uri, api_key: api_key )
      json = JSON.load(response.body)
      issues = []

      json["issues"].each do |data|
        p data["tracker"]
        if data["id"]
          issues << OpenStruct.new(data["tracker"])
        end
      end

      issues
    end
  end
end