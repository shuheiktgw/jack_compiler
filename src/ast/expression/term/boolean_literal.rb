require_relative '../../ast_base'

class BooleanLiteral < AstBase

  attr_reader :token, :value

  def initialize(token:, value:)
    @token = token
    @value = value
  end

  def to_vm(generator)
    if value
      generator.write_push(segment: 'constant', index: 1)
      generator.write_prefix_command('~')
      return
    end

    generator.write_push(segment: 'constant', index: 0)
  end
end