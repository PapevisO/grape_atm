module ATM
  class Setup < Grape::API
    namespace 'atm' do
      params do
        # Grape doesn't support parsing JSON array data in body at top level yet
        # https://github.com/ruby-grape/grape/issues/1730
        requires :payload,
                 type: Array[JSON],
                 desc: 'Deposit payload json array.<br>' +
                       'E.g. <pre>[{"denomination": 5, "quantity": 2}]</pre><br>' +
                       'See parameters description below:' +
                       '<pre>' + "\n" +
                       'denomination' + "\n" +
                       'type: Unsigned integer' + "\n" +
                       'possible values: ' + Payload::DENOMINATIONS.inspect + "\n" +
                       'description: Denomination of banknotes' + "\n" +
                       'quantity' + "\n" +
                       'type: Unsigned integer' + "\n" +
                       'description: Quantity of banknotes' + "\n" +
                       '</pre>' do
          requires :denomination,
                   type: Integer,
                   values: Payload::DENOMINATIONS,
                   desc: 'Denomination of banknotes',
                   documentation: { hidden: true, force_hidden: true }
          requires :quantity,
                   type: Integer,
                   desc: 'Quantity of banknotes',
                   documentation: { hidden: true, force_hidden: true }
        end
      end

      put '/' do
        Payload.setup(params[:payload])
        status 201
      end
    end
  end
end
