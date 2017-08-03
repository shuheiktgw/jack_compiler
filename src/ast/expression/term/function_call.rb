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
    raise 'Unimplemented yet!!!!!!!!!!!'
  end
end