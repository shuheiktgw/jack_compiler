require_relative '../token/token'
require_relative '../writer'

class Generator

  # TODO 配列の実装
  attr_reader :klass, :klass_name, :table, :writer, :label_count
  def initialize(klass:,table:, writer:)
    @klass = klass
    @klass_name = klass.class_name.literal
    @table = table
    @writer = writer
    @label_count = -1
  end

  def execute
    klass.to_vm(self)
  end

  def write_function(method_name:, number:)
    writer.write_function(name: "#{klass_name}.#{method_name}", number: number)

    unless klass_name == 'Main' && method_name == 'main'
      writer.write_push(segment: 'argument', index: 0)
      writer.write_pop(segment: 'pointer', index: 0)
    end

    table.notify_method_change(method_name)
  end

  def write_arguments(fcall)
    prefix = fcall.prefix.literal

    if prefix
      r = table.find(prefix, false)

      if r
        write_push(segment: 'argument', index: 0)
      end
    else
      # not sure if this is right...
      write_push(segment: 'argument', index: 0)
    end

    fcall.arguments.each{ |a| a.to_vm(generator) }
  end

  def write_substitution(name)
    segment, index = translate_identifier(name)
    writer.write_pop(segment: segment, index: index)
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

  def write_label(label)
    write.write_label(label)
  end

  def write_if_goto(label)
    write.write_if_goto(label)
  end

  def write_goto(label)
    write.write_goto(label)
  end

  def generate_label
    @label_count += 1
    "#{klass_name}#{label_count}"
  end

  def generate_function_name(fcall)
    prefix = fcall.prefix.literal

    p = if prefix
      r = table.find(prefix, false)

      if r
        r.type
      else
        prefix
      end
    else
      klass_name
    end

    "#{p}.#{fcall.function.literal}"
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
      writer.write_call(name: 'Math.multiply', number: 2)
    when Token::SLASH
      writer.write_call(name: 'Math.divide', number: 2)
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

  def translate_identifier(variable_name)
    row = table.find(variable_name)
    segment = row.segment
    index = row.index

    [segment, index]
  end
end