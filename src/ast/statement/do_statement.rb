require_relative '../ast_base'
require 'pry-byebug'

class DoStatement < AstBase

  attr_reader :token, :prefix, :function, :arguments

  def initialize(token:, prefix:, function:, arguments:)
    @token = token
    @prefix = prefix
    @function = function
    @arguments = arguments
  end

  def to_vm(generator)
    arguments.each{ |a| a.to_vm(generator) }

    function_name = if prefix
      "#{prefix.literal}.#{function.literal}"
    else
      "#{generator.klass_name.literal}.#{function.literal}"
    end

    generator.write_call(name: function_name, number: arguments.count)
  end
end