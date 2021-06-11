require 'spec_helper'

describe 'Info', type: :feature do
  it 'represents current payloads state' do
    payloads = [
      Payload.create(denomination: 1, quantity: 5),
      Payload.create(denomination: 2, quantity: 2)
    ]

    represented = ::ATM::Entities::Payload.represent payloads

    get 'atm'

    expect(json_response).to match_as_json represented
  end
end
