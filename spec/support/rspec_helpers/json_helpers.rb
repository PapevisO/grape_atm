module RSpecHelpers
  module JsonHelpers
    def json_response(options = {})
      defaults = {
        symbolize_names: true
      }
      
      JSON.parse(last_response.body, defaults.merge(options))
    end
  end
end
