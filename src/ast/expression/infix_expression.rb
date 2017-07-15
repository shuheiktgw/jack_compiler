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
    ] << right.to_h

    a.flatten
  end

  # Gyoku cannot parse plain array
  def to_xml
    self.to_h.map{|h| Gyoku.xml(h, unwrap: true)}.join('')
  end
end