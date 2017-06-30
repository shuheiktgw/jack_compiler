class NullLiteral < AstBase
  def initialize
    @token = Token.new(type: Token::NULL, literal: 'null')
    @value = nil
  end

  def to_h
    {
      term: {
        keyword: 'null'
      }
    }
  end
end