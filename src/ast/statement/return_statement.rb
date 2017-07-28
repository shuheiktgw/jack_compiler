require_relative '../ast_base'

class ReturnStatement < AstBase

  attr_reader :token, :return_value

  def initialize(token:, return_value:)
    @token = token
    @return_value = return_value
  end
end