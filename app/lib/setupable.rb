module Setupable
  def setup(params)
    transaction do
      params.each do |payload|
        record = find_or_initialize_by(denomination: payload[:denomination])
        record.quantity = payload[:quantity]
        record.save
      end
    end
  end
end
