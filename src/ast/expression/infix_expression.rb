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
      handle_term(left),
      { symbol: operator },
      handle_term(right)
    ]

    a.flatten
  end

  def handle_term(value)
    if value.term?
      { term: value.to_h }
    else
      value.to_h
    end
  end

  # Gyoku cannot parse plain array
  def to_xml
    self.to_h.map{|h| Gyoku.xml(h, unwrap: true)}.join('')
  end
end