require 'spec_helper'

shared_examples 'setupable' do
  it 'creates new record when no record with nominal is present' do
    expect(described_class.find_by(nominal: 10)).to be_nil
    described_class.setup([{ nominal: 10, number: 1 }])
    expect(described_class.find_by(nominal: 10)).to be_present
  end

  it 'updates existing record with nominal specified' do
    described_class.setup([{nominal: 5, number: 2}])
    expect(described_class.find_by(nominal: 5).number).to be 2
    expect(described_class.where(nominal: 5).count).to be 1
  end

  it 'wrapps calls in a transaction' do
    expect(described_class).to receive(:transaction).once
    described_class.setup([{ nominal: 1, number: 1 }])
  end
end
