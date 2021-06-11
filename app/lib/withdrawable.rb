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

      withdrawn = try_top_denomination_variations(amount, available.denomination_desc.all.to_a)
      return result if (result[:error] = get_unmatched_amount_error(withdrawn))

      save_withdraw(withdrawn)
    end

    result[:payload] = remap_denominations(withdrawn)
    result
  end

  def save_withdraw(payloads)
    payloads.each do |payload|
      record = find_by(denomination: payload[:denomination])
      record.quantity -= payload[:quantity]
      record.save
    end
  end

  def get_general_error(amount)
    return 'Wat?' if amount < 1

    return 'Cassette balance is insufficient' if amount > total
  end

  def get_unmatched_amount_error(denominations)
    return 'The amount temporarily cannot be matched' unless denominations
  end

  # The modified version of algorythm from https://github.com/joshuapaling/ruby-atm-microcourse/blob/master/step7_solution.rb
  def try_top_denomination_variations(amount, payloads)
    result = false
    if payloads.count == 1
      # There's no more denominations to try with.
      # We're at the lowest denomination we have
      try_with_single_denomination(amount, payloads.first)
    else
      top_payload = payloads.first
      top_payload_quantity = (amount / top_payload.denomination).floor
      top_payload_quantity = top_payload.quantity if top_payload_quantity > top_payload.quantity
      payloads.shift
      while top_payload_quantity >= 0 && !result && payloads.count
        remainder = amount - (top_payload_quantity * top_payload.denomination)
        result = try_top_denomination_variations(remainder, payloads)

        # add the correct quantity of the top denomination onto the front of the results array.
        result.push({ denomination: top_payload.denomination, quantity: top_payload_quantity }) if result
        top_payload_quantity -= 1
      end
      result
    end
  end

  def try_with_single_denomination(amount, payload)
    remainder = amount % payload.denomination
    prepared_quantity = amount / payload.denomination

    if remainder.positive? || prepared_quantity > payload.quantity
      false
    else
      [{ denomination: payload.denomination, quantity: prepared_quantity }]
    end
  end

  def remap_denominations(denominations)
    mapped = denominations.map do |denomination|
      next if denomination[:quantity].zero?

      { denomination[:denomination] => denomination[:quantity] }
    end

    mapped.compact
  end
end
