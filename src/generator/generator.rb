require_relative '../token/token'
require_relative '../writer'

class Generator

  attr_reader :klass, :klass_name, :table, :writer

  def initialize(klass:,table:, writer:)
    @klass = klass
    @klass_name = klass.class_name
    @table = table
    @writer = writer
  end

  def execute
    klass.to_vm(self)
  end

  def write_function(declaration)
    writer.write_function(name: "#{klass_name}.#{declaration.method_name}", number: declaration.parameters.count)
    write.write_push(segment: 'argument', index: 0)
    write.write_pop(segment: 'pointer', index: 0)
    table.notify_method_change(declaration.method_name)
  end

  def write_let(statement)
    statement.expression.to_vm(self)
    
    segment, index = translate_identifier(statement.identifier.value)
    writer.write_pop(segment: segment, index: index)
  end

  def translate_identifier(variable_name)
    row = table.find(variable_name)
    segment = translate_declaration(row.declaration_type)
    index = row.index

    [segment, index]
  end

  def write_push(segment:, index:)
    writer.write_push(segment: segment, index: index)
  end

  def write_return
    writer.write_return
  end

  def write_call(name:, number:)
    writer.write_call(name: name, number: number)
  end

  def translate_declaration(declaration_type)
    case declaration_type
    when 'argument'
      'arg'
    when 'field'
      'this'
    else
      declaration_type
    end
  end

  def write_command(command)
    case command
    when Token::EQ
      writer.write_command(Writer::EQ)
    when Token::NOT
      writer.write_command(Writer::NOT)
    when Token::PLUS
      writer.write_command(Writer::ADD)
    when Token::MINUS
      writer.write_command(Writer::NEG)
    when Token::ASTERISK
      writer.write_function(name: 'Math.multiply', number: 2)
    when Token::SLASH
      writer.write_function(name: 'Math.divide', number: 2)
    when Token::LT
      writer.write_command(Writer::LT)
    when Token::GT
      writer.write_command(Writer::GT)
    when Token::AND
      writer.write_command(Writer::AND)
    when Token::OR
      writer.write_command(Writer::OR)
    else
      raise "Unknown command is specified: #{command}"
    end
  end
end