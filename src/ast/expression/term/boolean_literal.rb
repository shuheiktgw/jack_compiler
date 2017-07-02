class BooleanLiteral < AstBase

  attr_reader :token, :value

  def initialize(token:, value:)
    @token = token
    @value = value
  end

  def to_h
    {
      term: {
        keyword: @value.to_s
      }
    }
  end
end