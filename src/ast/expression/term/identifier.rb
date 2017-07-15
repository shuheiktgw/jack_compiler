class Identifier < AstBase

  attr_reader :token, :value, :index

  def initialize(token:, value:, index: nil)
    @token = token
    @value = value
    @index = index
  end

  def to_h
    base = [
      {
        identifier: value
      }
    ]

    base << [ { symbol: '[' }, index.to_h, { symbol: ']' } ] if index

    base
  end
end