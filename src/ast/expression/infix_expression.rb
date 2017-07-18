class InfixExpression < AstBase

  attr_reader :token, :left, :operator, :right

  def initialize(token:, left:, operator:, right:)
    @token = token
    @left = left
    @operator = operator
    @right = right
  end

  def to_h
    a = [
      modify_indent(left),
      { symbol: operator },
      modify_indent(right)
    ]

    a.flatten
  end

  def modify_indent(value)
    if value.token.type == Token::IDENT
      {term: value.to_h}
    else
      value.to_h
    end
  end

  # Gyoku cannot parse plain array
  def to_xml
    self.to_h.map{|h| Gyoku.xml(h, unwrap: true)}.join('')
  end
end