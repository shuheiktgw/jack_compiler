require './src/ast/ast_base'

class LetStatement < AstBase

  attr_reader :token, :identifier, :expression

  def initialize(token:, identifier:, expression:)
    @token = token
    @identifier = identifier
    @expression =  expression
  end

  def to_vm(generator)
    if identifier.index
      r = generator.find_symbol(identifier.value)
      generator.write_push(segment: r.segment, index: r.index)

      identifier.index.to_vm(generator)
      generator.write_command('+')

      expression.to_vm(generator)
      generator.write_pop(segment: 'temp', index: 0)
      generator.write_pop(segment: 'pointer', index: 1)
      generator.write_push(segment: 'temp', index: 0)
      generator.write_pop(segment: 'that', index: 0)
    else
      expression.to_vm(generator)
      r = generator.find_symbol(identifier.value)
      generator.write_pop(segment: r.segment, index: r.index)
    end
  end
end