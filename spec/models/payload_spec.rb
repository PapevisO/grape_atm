require 'spec_helper'

describe Payload, type: :model do
  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:denomination) }
    it { is_expected.to validate_inclusion_of(:denomination).in_array(described_class::DENOMINATIONS) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
  end

  describe 'scopes' do
    it 'retrieves available records' do
      described_class.create(denomination: 1, quantity: 4)
      described_class.create(denomination: 5, quantity: 0)

      available = described_class.available
      expect(available.count).to be 1
      expect(available.first.denomination).to be 1
    end

    it 'orders records by denomination descending' do
      denomination1 = described_class.create(denomination: 1, quantity: 20)
      denomination25 = described_class.create(denomination: 25, quantity: 5)
      denomination10 = described_class.create(denomination: 10, quantity: 10)

      ordered = described_class.denomination_desc

      expect(ordered).to eq [denomination25, denomination10, denomination1]
    end
  end

  describe 'class methods' do
    it 'gets total amount of money' do
      described_class.create(denomination: 5, quantity: 4)
      described_class.create(denomination: 50, quantity: 2)
      described_class.create(denomination: 25, quantity: 2)

      expect(described_class.total).to eq 170
    end
  end

  it_behaves_like 'setupable'
  it_behaves_like 'withdrawable'
end
