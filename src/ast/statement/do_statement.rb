require_relative '../ast_base'

class DoStatement < AstBase

  attr_reader :token, :prefix, :function, :arguments

  def initialize(token:, prefix:, function:, arguments:)
    @token = token
    @prefix = prefix
    @function = function
    @arguments = arguments
  end

  def to_vm(generator)
    generator.write_do(self)
  end
end