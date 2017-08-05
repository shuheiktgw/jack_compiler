require_relative '../../ast_base'

class ThisLiteral < AstBase

  attr_reader :token, :value

  def initialize
    @token = Token.new(type: Token::THIS, literal: 'this')
    @value = nil
  end

  def to_vm(generator)
    generator.write_push(segment: 'pointer', index: 0)
  end
end