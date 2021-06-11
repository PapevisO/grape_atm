module GrapeSwagger
  module Endpoint
    class ParamsParser
      private

      def public_parameter?(param)
        param_options = param.last

        return true if insist_public_parameter?(param_options)

        param_hidden = param_options.dig(:documentation, :hidden) || false
        if param_hidden.is_a?(Proc)
          param_hidden = if settings[:token_owner]
                           param_hidden.call(endpoint.send(settings[:token_owner].to_sym))
                         else
                           param_hidden.call
                         end
        end
        !param_hidden
      end

      def insist_public_parameter?(param_options)
        return false if param_options.dig(:documentation, :force_hidden)

        param_options[:required]
      end
    end
  end
end
