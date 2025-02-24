require 'spec_helper'

describe 'Api is running', type: :feature do
  it 'responds with status ok' do
    get 'is_alive'

    expect(last_response.status).to eq 201
  end
end
