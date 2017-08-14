require_relative '../ast_base'

class InfixExpression < AstBase

  attr_reader :token, :left, :operator, :right

  def initialize(token:, left:, operator:, right:)
    @token = token
    @left = left
    @operator = operator
    @right = right
  end

  def to_vm(generator)
    left.to_vm(generator)
    right.to_vm(generator)
    generator.write_infix_command(operator)
  end
end