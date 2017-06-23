class LetStatement

  LET_XML = 'letStatement'.freeze

  def initialize(token:, identifier:, expression:)
    @token = token
    @identifier = identifier
    @expression =  expression
  end

  def to_h
    {
      LET_XML => [
        {keyword: 'let'},
        @identifier.to_h,
        {symbol: '='},
        @expression.to_h,
        symbol: ';'
      ]
    }
  end
end