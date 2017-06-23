class IntegerLiteral
  def initialize(token:, value:)
    @token = token
    @value = value
  end

  def to_h
    {
      term: {
        integerConstant: @value
      }
    }
  end
end