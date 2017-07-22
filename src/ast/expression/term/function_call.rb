require_relative '../../ast_base'

class FunctionCall < AstBase

  attr_reader :token, :prefix, :function, :arguments

  def initialize(token:, prefix:, function:, arguments:)
    @token = token
    @prefix = prefix
    @function = function
    @arguments = arguments
  end

  def term?
    true
  end

  def to_h
    fc = []

    fc << handle_prefix(prefix) if prefix
    fc << {symbol: '.'} if prefix
    fc << {identifier: function.literal}
    fc << {symbol: '('}
    fc << {expressionList: arguments.map(&:to_h).flatten}
    fc << {symbol: ')'}

    fc.flatten
  end

  def handle_prefix(prefix)
    if prefix.type == Token::THIS
      {keyword: prefix.literal}
    else
      {identifier: prefix.literal}
    end
  end
end