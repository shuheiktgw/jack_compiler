require 'forwardable'
require_relative '../token/token'
require_relative '../writer'

class Generator
  extend Forwardable

  def_delegators :writer, :write_return, :write_call, :write_label, :write_push, :write_if_goto, :write_goto
  attr_reader :klass, :klass_name, :symbol_table, :function_table, :writer, :label_count

  def initialize(klass:, symbol_table:, function_table:, writer:)
    @klass = klass
    @klass_name = klass.class_name.literal
    @symbol_table = symbol_table
    @function_table = function_table
    @writer = writer
    @label_count = -1
  end

  def execute
    klass.to_vm(self)
  end

  def write_function(method_type:, method_name:, number:)
    write_function(name: "#{klass_name}.#{method_name}", number: number)

    if method_type == 'constructor'
      write_push(segment: 'constant', index: number)
      write_call(name: 'Memory.alloc', number: 1)
      writer.write_pop(segment: 'pointer', index: 0)
    end

    if method_type == 'method'
      writer.write_push(segment: 'argument', index: 0)
      writer.write_pop(segment: 'pointer', index: 0)
    end

    symbol_table.notify_method_change(method_name)
  end

  def write_arguments(fcall)
    prefix = fcall.prefix.literal

    if prefix
      r = symbol_table.find(prefix, false)

      if r
        write_push(segment: r.segment, index: r.index)
      end
    else
      # not sure if this is right...
      write_push(segment: 'argument', index: 0)
    end

    fcall.arguments.each{ |a| a.to_vm(self) }
  end

  def write_let(let_stmt)
    index = let_stmt.identifier.index

    if index
      arr_segment, arr_index = translate_identifier(let_stmt.identifier.value)
      generator.write_push(segment: arr_segment, index: arr_index)
      index.to_vm(self)
      write_command('add')

      let_stmt.expression.to_vm(self)
      write_pop(segmetn: 'temp', index: 0)
      write_pop(segment: 'pointer', index: 1)
      write_push(segment: 'temp', index: 0)
      write_pop(segmnt: 'that', index: 0)
    else
      let_stmt.expression.to_vm(self)
      segment, index = translate_identifier(let_stmt.identifier.value)
      writer.write_pop(segment: segment, index: index)
    end
  end

  def generate_label
    @label_count += 1
    "#{klass_name}#{label_count}"
  end

  def generate_function_name(fcall)
    prefix = fcall.prefix.literal

    p = if prefix
      r = symbol_table.find(prefix, false)

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

  def count_arguments(fcall)
    prefix = fcall.prefix.literal
    count = fcall.arguments.count

    if prefix
      r = symbol_table.find(prefix, false)

      if r
        count + 1
      else
        count
      end
    else
      count + 1
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
    row = symbol_table.find(variable_name)
    segment = row.segment
    index = row.index

    [segment, index]
  end

  def void?(fcall)
    prefix = fcall.prefix.literal
    fname = fcall.function.literal

    kname = if prefix
      r = symbol_table.find(prefix, false)

      if r
        r.type
      else
        prefix
      end
    else
      klass_name
    end

    function_table.void?(klass_name: kname, method_name: fname)
  end
end