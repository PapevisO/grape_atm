module ATM
  class Withdraw < Grape::API
    namespace 'atm' do
      params do
        requires :amount, type: Integer, desc: 'That much to withdraw'
      end

      post '/withdraw' do
        result = Payload.withdraw(params[:amount])
        if result[:error]
          status 400
          return result[:error]
        end

        status 200
        result[:payload]
      end
    end
  end
end
