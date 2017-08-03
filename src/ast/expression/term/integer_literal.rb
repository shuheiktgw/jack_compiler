require_relative '../../ast_base'

class IntegerLiteral < AstBase

  attr_reader :token, :value

  def initialize(token:, value:)
    @token = token
    @value = value
  end

  def to_vm(generator)
    generator.write_push(segment: 'constant', index: value)
  end
end