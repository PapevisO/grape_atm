module Setupable
  def setup (params)
    transaction do
      params.each do |payload|
        record = find_or_initialize_by(nominal: payload[:nominal])
        record.number = payload[:number]
        record.save
      end
    end
  end
end
