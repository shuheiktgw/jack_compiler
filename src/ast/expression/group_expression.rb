class GroupExpression < AstBase

  attr_reader :expression

  def initialize(expression:)
    @expression = expression
  end

  def to_h
    [
      {symbol: '('},
      handle_expression(expression),
      {symbol: ')'}
    ]

  end

  def term?
    true
  end

  def handle_expression(exo)
    term = if exo.term?
      { term: exo.to_h }
    else
      exo.to_h
    end

    { expression:  term}
  end
end