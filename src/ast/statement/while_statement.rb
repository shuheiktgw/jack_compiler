class WhileStatement < AstBase

  attr_reader :token, :condition, :consequence

  def initialize(token:, condition:, consequence:)
    @token = token
    @condition = condition
    @consequence = consequence
  end

  def to_h
    whiles = []

    whiles << { keyword: 'while' }
    whiles << { symbol: '(' }
    whiles << { symbol: '(' }
    whiles << handle_expression(condition)
    whiles << { symbol: ')' }
    whiles << { symbol: '{' }
    whiles << consequence.to_h
    whiles << { symbol: '}' }

    { whileStatement:  whiles }
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