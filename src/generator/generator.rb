require 'forwardable'
require_relative '../token/token'
require_relative '../writer'

class Generator
  extend Forwardable

  def_delegators :writer, :write_return, :write_call, :write_label, :write_push, :write_pop, :write_if, :write_goto
  def_delegators :function_table, :method?, :void?
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

  def write_function(method_type:, method_name:)
    symbol_table.notify_method_change(method_name)

    writer.write_function(name: "#{klass_name}.#{method_name}", number: symbol_table.count_vars)

    if method_type == 'constructor'
      write_push(segment: 'constant', index: symbol_table.count_vars)
      write_call(name: 'Memory.alloc', number: 1)
      write_pop(segment: 'pointer', index: 0)
    end

    if method_type == 'method'
      write_push(segment: 'argument', index: 0)
      write_pop(segment: 'pointer', index: 0)
    end
  end

  def generate_label
    @label_count += 1
    "#{klass_name}#{label_count}"
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

  def find_symbol(variable_name, raise_error = false)
    symbol_table.find(variable_name, raise_error)
  end
end