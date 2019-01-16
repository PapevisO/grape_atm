RSpec::Matchers.define :match_as_json do |expected|
  match do |actual|
    @expected = normalize_data(expected)
    @actual = normalize_data(actual)

    expect(@expected).to eq(@actual)
  end
  attr_reader :actual, :expected

  diffable

  def normalize_data(x)
    serialized = x.as_json
    symbolized = { value: serialized }.deep_symbolize_keys
    symbolized[:value]
  end
end
