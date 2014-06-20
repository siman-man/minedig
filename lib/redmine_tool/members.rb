module RedmineTool
  module Members 
    def member_list
      uri = Query::create( host: redmine_host, path: path, method: '/memberships.json' )
      response = Query::send( uri: uri, api_key: api_key )
      json = JSON.load(response.body)

      json["memberships"].map do |data|
        if data["user"]
          data["user"]["name"]
        end
      end.compact
    end
  end
end