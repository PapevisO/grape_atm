require 'spec_helper'

describe 'Info', type: :feature do
  it 'represents current payloads state' do
    payloads = [
      Payload.create(nominal: 1, number: 5),
      Payload.create(nominal: 2, number: 2)
    ]

    represented = ::ATM::Entities::Payload.represent payloads

    get 'api/v1/atm'

    expect(json_response).to match_as_json represented
  end
end
