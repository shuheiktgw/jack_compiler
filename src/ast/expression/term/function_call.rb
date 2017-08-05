require_relative '../../ast_base'

class FunctionCall < AstBase

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

    generator.write_call(name: function_name, number: arguments.count)
  end
end