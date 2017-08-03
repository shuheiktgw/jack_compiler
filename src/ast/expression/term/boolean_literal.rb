require_relative '../../ast_base'

class BooleanLiteral < AstBase

  attr_reader :token, :value

  def initialize(token:, value:)
    @token = token
    @value = value
  end

  def to_vm(generator)
    v = value ? 1 : 0
    generator.write_push(segment: 'constant', index: v)
  end
end