class PrefixExpression < AstBase

  attr_reader :token, :operator, :right

  def initialize(token:, operator:, right:)
    @token = token
    @operator = operator
    @right = right
  end

  def to_h
    raise 'This should be implemented'
  end
end