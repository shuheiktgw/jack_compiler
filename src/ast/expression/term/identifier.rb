require_relative '../../ast_base'

class Identifier < AstBase

  attr_reader :token, :value, :index

  def initialize(token:, value:, index: nil)
    @token = token
    @value = value
    @index = index
  end

  def term?
    true
  end

  def to_h
    base = [
      {
        identifier: value
      }
    ]

    base << [ { symbol: '[' }, handle_expression(index), { symbol: ']' } ] if index

    base.flatten
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