require_relative '../../ast_base'
require_relative '../../../helper/callable'

class FunctionCall < AstBase
  include Callable

  attr_reader :token, :prefix, :function, :arguments

  def initialize(token:, prefix:, function:, arguments:)
    @token = token
    @prefix = prefix
    @function = function
    @arguments = arguments
  end

  def to_vm(generator)
    write_arguments generator

    generator.write_call(name: function_name, number: arguments_count)
    generator.write_pop(segment: 'temp', index: 0) if void?
  end
end