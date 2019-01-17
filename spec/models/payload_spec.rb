require 'spec_helper'

describe Payload, type: :model do
  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:nominal) }
    it { is_expected.to validate_inclusion_of(:nominal).in_array(described_class::NOMINALS) }
    it { is_expected.to validate_numericality_of(:number).is_greater_than_or_equal_to(0) }
  end

  describe 'scopes' do
    it 'retrieves available records' do
      described_class.create(nominal: 1, number: 4)
      described_class.create(nominal: 5, number: 0)

      available = described_class.available
      expect(available.count).to be 1
      expect(available.first.nominal).to be 1
    end

    it 'orders records by nominal descending' do
      nominal1 = described_class.create(nominal: 1, number: 20)
      nominal25 = described_class.create(nominal: 25, number: 5)
      nominal10 = described_class.create(nominal: 10, number: 10)

      ordered = described_class.nominal_desc

      expect(ordered).to eq [nominal25, nominal10, nominal1]
    end
  end

  describe 'class methods' do
    it 'gets total amount of money' do
      described_class.create(nominal: 5, number: 4)
      described_class.create(nominal: 50, number: 2)
      described_class.create(nominal: 25, number: 2)

      expect(described_class.total).to eq 170
    end
  end

  it_behaves_like 'setupable'
  it_behaves_like 'withdrawable'
end
