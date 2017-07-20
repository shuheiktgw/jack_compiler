class PrefixExpression < AstBase

  attr_reader :token, :operator, :right

  def initialize(token:, operator:, right:)
    @token = token
    @operator = operator
    @right = right
  end

  def term?
    true
  end

  def to_h
    [
      {symbol: operator},
      handle_term(right)
    ]
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