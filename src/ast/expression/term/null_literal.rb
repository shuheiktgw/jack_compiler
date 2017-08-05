require_relative '../../ast_base'

class NullLiteral < AstBase

  attr_reader :token, :value

  def initialize
    @token = Token.new(type: Token::NULL, literal: 'null')
    @value = nil
  end

  def to_vm(generator)
    generator.write_push(segment: 'constant', inedx: 0)
  end
end