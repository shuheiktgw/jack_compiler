require_relative '../ast_base'

class LetStatement < AstBase

  attr_reader :token, :identifier, :expression

  def initialize(token:, identifier:, expression:)
    @token = token
    @identifier = identifier
    @expression =  expression
  end

  def to_h
    {
      letStatement: [
        {keyword: 'let'},
        identifier.to_h,
        {symbol: '='},
        handle_expression(expression),
        symbol: ';'
      ].flatten
    }
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