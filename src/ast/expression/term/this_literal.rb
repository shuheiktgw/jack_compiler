require_relative '../../ast_base'

class ThisLiteral < AstBase

  attr_reader :token, :value

  def initialize
    @token = Token.new(type: Token::THIS, literal: 'this')
    @value = nil
  end
end