require_relative '../ast_base'

class WhileStatement < AstBase

  attr_reader :token, :condition, :consequence

  def initialize(token:, condition:, consequence:)
    @token = token
    @condition = condition
    @consequence = consequence
  end
end