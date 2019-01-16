require 'spec_helper'

describe Payload, type: :model do
  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:nominal) }
    it { is_expected.to validate_inclusion_of(:nominal).in_array(described_class::NOMINALS)}
  end

  it_behaves_like 'setupable'
end
