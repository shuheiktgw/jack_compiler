require_relative '../../ast_base'

class IntegerLiteral < AstBase

  attr_reader :token, :value

  def initialize(token:, value:)
    @token = token
    @value = value
  end
end