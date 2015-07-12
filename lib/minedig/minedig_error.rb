module Minedig
  class MinedigError < StandardError; end

  class NotFoundProjectError < MinedigError
    def message
      %q(Not found project.)
    end
  end
end