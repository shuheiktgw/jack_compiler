class InfixExpression < AstBase
  def initialize(token:, left:, operator:, right:)
    @token = token
    @left = left
    @operator = operator
    @right = right
  end

  def to_h
    raise 'This should be implemented'
  end
end