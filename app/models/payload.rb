class Payload < ActiveRecord::Base
  extend ::Setupable
  NOMINALS = [1, 2, 5, 10, 25, 50]

  validates_uniqueness_of :nominal
  validates_inclusion_of :nominal, in: NOMINALS
end
