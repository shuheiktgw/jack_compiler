class GroupExpression < AstBase

  attr_reader :expression

  def initialize(expression:)
    @expression = expression
  end

  def to_h
    raise
  end
end