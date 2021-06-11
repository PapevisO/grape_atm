require 'spec_helper'

shared_examples 'withdrawable' do
  describe 'validation' do
    it 'checks if there is enough money' do
      described_class.create(denomination: 5, quantity: 1)
      result = described_class.withdraw(10)
      expect(result[:payload]).to be_empty
      expect(result[:error]).to be_present

      record = described_class.find_by(denomination: 5)
      expect(record[:quantity]).to eq 1
    end

    it 'checks if the amount can be returned exactly' do
      described_class.create(denomination: 5, quantity: 2)
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

  describe 'properly calculates the quantity of denominations' do
    it 'uses highest denominations available' do
      described_class.create(denomination: 1, quantity: 3)
      described_class.create(denomination: 2, quantity: 2)
      described_class.create(denomination: 5, quantity: 30)
      described_class.create(denomination: 10, quantity: 10)

      result = described_class.withdraw(12)
      expect(result[:error]).to be_nil
      expect(result[:payload]).to match_array [{ 10 => 1 }, { 2 => 1 }]
    end

    it 'combines properly for decending regression case' do
      described_class.create(denomination: 25, quantity: 1)
      described_class.create(denomination: 10, quantity: 4)

      result = described_class.withdraw(30)
      expect(result[:error]).to be_nil
      expect(result[:payload]).to match_array [{ 10 => 3 }]
    end

    it 'combines properly for accending regression case' do
      described_class.create(denomination: 25, quantity: 3)
      described_class.create(denomination: 10, quantity: 3)

      result = described_class.withdraw(75)
      expect(result[:error]).to be_nil
      expect(result[:payload]).to match_array [{ 25 => 3 }]
    end
  end

  it 'reduces the quantity of banknotes available' do
    described_class.create(denomination: 50, quantity: 3)
    described_class.withdraw(100)
    denomination50 = described_class.find_by(denomination: 50)
    expect(denomination50.quantity).to eq 1
  end
end
