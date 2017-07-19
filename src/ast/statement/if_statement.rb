class IfStatement < AstBase

  attr_reader :token, :condition, :consequence, :alternative

  def initialize(token:, condition:, consequence:, alternative:)
    @token = token
    @condition = condition
    @consequence = consequence
    @alternative = alternative
  end

  def to_h
    ifs = [
      { keyword: 'do' }
    ]

    ifs << { symbol: '(' }




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