module Redmine
  module Members 
    def member_list
      uri = Query::create( host: redmine_host, path: path, method: '/memberships.json' )
      response = Query::send( uri: uri, api_key: api_key )
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