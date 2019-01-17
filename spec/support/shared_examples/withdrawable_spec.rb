require 'spec_helper'

shared_examples 'withdrawable' do
  describe 'validation' do
    it 'checks if there is enough money' do
      described_class.create(nominal: 5, number: 1)
      result = described_class.withdraw(10)
      expect(result[:payload]).to be_empty
      expect(result[:error]).to be_present

      record = described_class.find_by(nominal: 5)
      expect(record[:number]).to eq 1
    end

    it 'checks if the amount can be returned exactly' do
      described_class.create(nominal: 5, number: 2)
      result = described_class.withdraw(7)
      expect(result[:payload]).to be_empty
      expect(result[:error]).to be_present
    end
  end

  it 'wraps withdraw in transaction' do
    expect(described_class).to receive(:transaction).once
    described_class.withdraw(9000)
  end

  it 'locks the content during withdrawal' do
    expect(described_class).to receive(:lock).once
    described_class.withdraw(40_000)
  end

  describe 'properly calculates the number of nominals' do
    it 'uses highest nominals available' do
      described_class.create(nominal: 1, number: 3)
      described_class.create(nominal: 2, number: 2)
      described_class.create(nominal: 5, number: 30)
      described_class.create(nominal: 10, number: 10)

      result = described_class.withdraw(12)
      expect(result[:error]).to be_nil
      expect(result[:payload]).to match_array [{ 10 => 1 }, { 2 => 1 }]
    end

    it 'combines properly for decending regression case' do
      described_class.create(nominal: 25, number: 1)
      described_class.create(nominal: 10, number: 4)

      result = described_class.withdraw(30)
      expect(result[:error]).to be_nil
      expect(result[:payload]).to match_array [{ 10 => 3 }]
    end

    it 'combines properly for accending regression case' do
      described_class.create(nominal: 25, number: 3)
      described_class.create(nominal: 10, number: 3)

      result = described_class.withdraw(75)
      expect(result[:error]).to be_nil
      expect(result[:payload]).to match_array [{ 25 => 3 }]
    end
  end

  it 'reduces the number of banknotes available' do
    described_class.create(nominal: 50, number: 3)
    described_class.withdraw(100)
    nominal50 = described_class.find_by(nominal: 50)
    expect(nominal50.number).to eq 1
  end
end
