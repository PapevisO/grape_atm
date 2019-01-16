require 'spec_helper'

describe 'Api is running', type: :feature do
  it 'responds with status ok' do
    get 'api/v1/is_alive'

    expect(json_response[:status]).to eq 'ok'
  end
end
