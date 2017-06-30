class LetStatement < AstBase

  attr_reader :token, :identifier, :expression

  def initialize(token:, identifier:, expression:)
    @token = token
    @identifier = identifier
    @expression =  expression
  end

  def to_h
    {
      letStatement: [
        {keyword: 'let'},
        @identifier.to_h,
        {symbol: '='},
        @expression.to_h,
        symbol: ';'
      ]
    }
  end
end