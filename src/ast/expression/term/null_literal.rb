require_relative '../../ast_base'

class NullLiteral < AstBase

  attr_reader :token, :value

  def initialize
    @token = Token.new(type: Token::NULL, literal: 'null')
    @value = nil
  end

  def term?
    true
  end

  def to_h
    {
      keyword: 'null'
    }
  end
end