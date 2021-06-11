require 'spec_helper'

shared_examples 'setupable' do
  it 'creates new record when no record with denomination is present' do
    expect(described_class.find_by(denomination: 10)).to be_nil
    described_class.setup([{ denomination: 10, quantity: 1 }])
    expect(described_class.find_by(denomination: 10)).to be_present
  end

  it 'updates existing record with denomination specified' do
    described_class.setup([{ denomination: 5, quantity: 2 }])
    expect(described_class.find_by(denomination: 5).quantity).to be 2
    expect(described_class.where(denomination: 5).count).to be 1
  end

  it 'wrapps calls in a transaction' do
    expect(described_class).to receive(:transaction).once
    described_class.setup([{ denomination: 1, quantity: 1 }])
  end
end
