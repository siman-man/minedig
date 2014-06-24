module RedmineTool
  class Project
    include Query
    include Members
    include Issues

    attr_accessor :user_name, :redmine_host, :path, :api_key
    
    def initialize
      if block_given?
        yield self
      end
    end
  end
end