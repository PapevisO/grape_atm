require 'spec_helper'

describe 'Setup', type: :feature do
  it 'updates atm state' do
    params = {
      payload: [
        { denomination: 5, quantity: 7 }
      ]
    }
    put 'atm', params
    expect(last_response.status).to eq 201

    get 'atm'
    expect(json_response).to match_as_json([{ denomination: 5, quantity: 7 }])
  end
end
