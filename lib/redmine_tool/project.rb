module RedmineTool
  class Project
    include Query
    include Members

    attr_accessor :user_name, :redmine_host, :path, :api_key
    
    def initialize
      if block_given?
        yield self
      end
    end

    def full_path
      uri = URI::HTTP.build( host: redmine_host, path: path ).to_s
    end
  end
end