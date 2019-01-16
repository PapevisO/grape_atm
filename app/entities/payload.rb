module ATM
  module Entities
    class Payload < Grape::Entity
      expose :nominal
      expose :number
    end
  end
end
