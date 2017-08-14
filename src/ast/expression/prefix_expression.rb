require_relative '../ast_base'

class PrefixExpression < AstBase

  attr_reader :token, :operator, :right

  def initialize(token:, operator:, right:)
    @token = token
    @operator = operator
    @right = right
  end

  def to_vm(generator)
    right.to_vm(generator)
    generator.write_prefix_command(operator)
  end
end