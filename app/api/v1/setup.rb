module ATM
  class Setup < Grape::API
    namespace 'atm' do
      params do
        # Grape doesn't support parsing JSON array data in body at top level yet
        # https://github.com/ruby-grape/grape/issues/1730
        requires :payload, type: Array[JSON] do
          requires :nominal, type: Integer, values: Payload::NOMINALS, desc: 'Nominal of banknotes'
          requires :number, type: Integer, desc: 'Number of banknotes'
        end
      end

      put '/' do
        Payload.setup(params[:payload])
        status 201
      end
    end
  end
end
