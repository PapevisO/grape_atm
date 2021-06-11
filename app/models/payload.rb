class Payload < ActiveRecord::Base
  extend ::Setupable
  extend ::Withdrawable

  DENOMINATIONS = [1, 2, 5, 10, 25, 50].freeze

  validates_uniqueness_of :denomination
  validates_inclusion_of :denomination, in: DENOMINATIONS
  validates_numericality_of :quantity, greater_than_or_equal_to: 0

  scope :available, -> { where('quantity > 0') }
  scope :denomination_desc, -> { order(denomination: :desc) }

  def self.total
    all.inject(0) { |result, record| result + record.denomination * record.quantity }
  end
end
