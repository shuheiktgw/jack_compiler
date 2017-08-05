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
    generator.write_arguments(self)
    function_name = generator.generate_function_name(self)
    arguments_count = generator.count_arguments(self)

    generator.write_call(name: function_name, number: arguments_count)
  end
end