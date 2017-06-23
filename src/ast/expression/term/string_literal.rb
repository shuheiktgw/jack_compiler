class StringLiteral
  def initialize(token:, value:)
    @token = token
    @value = value
  end

  def to_h
    {
      term: {
        stringConstant: @value
      }
    }
  end
end