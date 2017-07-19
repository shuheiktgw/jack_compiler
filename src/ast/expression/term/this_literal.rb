class ThisLiteral < AstBase

  attr_reader :token, :value

  def initialize
    @token = Token.new(type: Token::THIS, literal: 'this')
    @value = nil
  end

  def term?
    true
  end

  def to_h
    {
      keyword: 'this'
    }
  end
end