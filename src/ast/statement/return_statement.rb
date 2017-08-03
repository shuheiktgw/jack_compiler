require_relative '../ast_base'

class ReturnStatement < AstBase

  attr_reader :token, :return_value

  def initialize(token:, return_value:)
    @token = token
    @return_value = return_value
  end

  def to_vm(generator)
    return_value.to_vm(generator)
    generator.write_return
  end
end