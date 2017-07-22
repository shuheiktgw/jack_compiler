require_relative '../ast_base'

class ReturnStatement < AstBase

  attr_reader :token, :return_value

  def initialize(token:, return_value:)
    @token = token
    @return_value = return_value
  end

  def to_h
    {
      returnStatement: form_value(return_value)
    }
  end

  def form_value(value)
    if value
      v = if value.term?
        { term: value.to_h }
      else
        value.to_h
      end



      {
        keyword: 'return',
        expression: v,
        symbol: ';'
      }
    else
      {
        keyword: 'return',
        symbol: ';'
      }
    end
  end
end