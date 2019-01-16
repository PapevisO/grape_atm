require 'spec_helper'

describe 'Setup', type: :feature do
  it 'updates atm state' do
    params = {
      payload: [
        { nominal: 5, number: 7 }
      ]
    }
    post 'api/v1/atm', params

    expect(last_response.status).to eq 201
    payloads = Payload.all
    expect(payloads.count).to eq 1
    expect(payloads.first.nominal).to eq 5
    expect(payloads.first.number).to eq 7
  end
end
