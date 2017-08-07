require_relative '../../ast_base'

class Identifier < AstBase

  attr_reader :token, :value, :index

  def initialize(token:, value:, index: nil)
    @token = token
    @value = value
    @index = index
  end

  def to_vm(generator)
    segment, memory_index = generator.translate_identifier(value)
    generator.write_push(segment: segment, index: memory_index)

    if index
      index.to_vm(generator)
      generator.write_command('+')
      generator.write_pop(segment: 'pointer', index: 1)
      generator.write_push(segment: 'that', index: 0)
    end
  end
end