class PrefixExpression < AstBase

  attr_reader :token, :operator, :right

  def initialize(token:, operator:, right:)
    @token = token
    @operator = operator
    @right = right
  end

  def to_h
    {
      expression: [
        {symbol: operator},
        modified_right
      ]
    }
  end

  def modified_right
    if right.token.type == Token::IDENT
      {term: right.to_h}
    else
      right.to_h
    end
  end
end