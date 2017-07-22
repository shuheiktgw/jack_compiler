require_relative '../ast_base'

class IfStatement < AstBase

  attr_reader :token, :condition, :consequence, :alternative

  def initialize(token:, condition:, consequence:, alternative:)
    @token = token
    @condition = condition
    @consequence = consequence
    @alternative = alternative
  end

  def to_h
    ifs = []

    ifs << { keyword: 'if' }
    ifs << { symbol: '(' }
    ifs << { symbol: '(' }
    ifs << handle_expression(@condition)
    ifs << { symbol: ')' }
    ifs << { symbol: '{' }
    ifs << consequence.to_h
    ifs << { symbol: '}' }
    ifs << { keyword: 'else' } if alternative
    ifs << { symbol: '{' } if alternative
    ifs << alternative.to_h if alternative
    ifs << { symbol: '}' } if alternative

    { if_statement:  ifs }
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