class BooleanLiteral < AstBase
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