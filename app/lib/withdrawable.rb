module Withdrawable
  def withdraw(amount)
    withdrawn = []
    result = {
      error: nil,
      payload: []
    }

    transaction do
      lock

      return result if (result[:error] = get_general_error(amount))

      withdrawn = try_top_nominal_variations(amount, self.available.nominal_desc.all.to_a)
      return result if (result[:error] = get_unmatched_amount_error(withdrawn))

      save_withdraw(withdrawn)
    end

    result[:payload] = remap_nominals(withdrawn)
    result
  end

  def save_withdraw(payloads)
    payloads.each do |payload|
      record = find_by(nominal: payload[:nominal])
      record.number -= payload[:number]
      record.save
    end
  end

  def get_general_error(amount)
    return 'Wat?' if amount < 1

    return 'Not enough money' if amount > self.total
  end

  def get_unmatched_amount_error(nominals)
    return 'The amount cannot be withdrawn exactly' unless nominals
  end

  # The modified version of algorythm from https://github.com/joshuapaling/ruby-atm-microcourse/blob/master/step7_solution.rb
  def try_top_nominal_variations(amount, payloads)
    result = false
    if payloads.count == 1
      # There's no more nominals to try with.
      # We're at the lowest nominal we have
      return try_with_single_nominal(amount, payloads.first)
    else
      top_payload = payloads.first
      top_payload_number = (amount / top_payload.nominal).floor
      top_payload_number = top_payload.number if top_payload_number > top_payload.number
      payloads.shift
      while top_payload_number >= 0 && !result && payloads.count
        remainder = amount - (top_payload_number * top_payload.nominal)
        result = try_top_nominal_variations(remainder, payloads)

        # add the correct number of the top nominal onto the front of the results array.
        result.push({ nominal: top_payload.nominal, number: top_payload_number }) if result
        top_payload_number -= 1
      end
      return result
    end
  end

  def try_with_single_nominal(amount, payload)
    remainder = amount % payload.nominal
    necessary_number = amount / payload.nominal

    if remainder.positive? || necessary_number > payload.number
      result = false
    else
      result = [{ nominal: payload.nominal, number: necessary_number }]
    end
    result
  end

  def remap_nominals(nominals)
    mapped = nominals.map do |nominal|
      next if nominal[:number].zero?
      { nominal[:nominal] => nominal[:number] }
    end

    mapped.compact
  end
end
