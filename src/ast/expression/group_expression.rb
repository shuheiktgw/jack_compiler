require_relative '../ast_base'

class GroupExpression < AstBase

  attr_reader :expression

  def initialize(expression:)
    @expression = expression
  end
end