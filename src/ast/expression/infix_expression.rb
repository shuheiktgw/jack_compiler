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
      left.to_h,
      { symbol: operator },
    ] << modified_right

    a.flatten
  end

  def modified_right
    if right.token.type == Token::IDENT
      {term: right.to_h}
    else
      right.to_h
    end
  end

  # Gyoku cannot parse plain array
  def to_xml
    self.to_h.map{|h| Gyoku.xml(h, unwrap: true)}.join('')
  end
end