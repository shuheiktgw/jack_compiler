require_relative '../ast_base'

class LetStatement < AstBase

  attr_reader :token, :identifier, :expression

  def initialize(token:, identifier:, expression:)
    @token = token
    @identifier = identifier
    @expression =  expression
  end

  def to_vm(generator)
    if identifier.index
      arr_segment, arr_index = generator.translate_identifier(identifier.value)
      generator.write_push(segment: arr_segment, index: arr_index)
      identifier.index.to_vm(self)
      generator.write_command('add')

      expression.to_vm(self)
      generator.write_pop(segmetn: 'temp', index: 0)
      generator.write_pop(segment: 'pointer', index: 1)
      generator.write_push(segment: 'temp', index: 0)
      generator.write_pop(segmnt: 'that', index: 0)
    else
      expression.to_vm(self)
      segment, index = translate_identifier(identifier.value)
      generator.writer.write_pop(segment: segment, index: index)
    end
  end
end