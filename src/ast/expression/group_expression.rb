require_relative '../ast_base'

class GroupExpression < AstBase

  attr_reader :expression

  def initialize(expression:)
    @expression = expression
  end

  def to_vm(generator)
    expression.to_vm(generator)
  end
end