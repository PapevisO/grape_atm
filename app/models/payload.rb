class Payload < ActiveRecord::Base
  extend ::Setupable
  extend ::Withdrawable

  NOMINALS = [1, 2, 5, 10, 25, 50].freeze

  validates_uniqueness_of :nominal
  validates_inclusion_of :nominal, in: NOMINALS
  validates_numericality_of :number, greater_than_or_equal_to: 0

  scope :available, -> { where('number > 0') }
  scope :nominal_desc, -> { order(nominal: :desc) }

  def self.total
    all.inject(0) { |result, record| result + record.nominal * record.number}
  end
end
