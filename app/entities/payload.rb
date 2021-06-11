require 'grape-entity'

module ATM
  module Entities
    class Payload < Grape::Entity
      expose :denomination
      expose :quantity
    end
  end
end
