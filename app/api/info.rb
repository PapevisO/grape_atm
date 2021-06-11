module ATM
  class Info < Grape::API
    namespace 'atm' do
      get '/' do
        ::ATM::Entities::Payload.represent Payload.all
      end
    end
  end
end
