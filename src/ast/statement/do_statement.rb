require_relative '../ast_base'

class DoStatement < AstBase

  attr_reader :token, :prefix, :function, :arguments

  def initialize(token:, prefix:, function:, arguments:)
    @token = token
    @prefix = prefix
    @function = function
    @arguments = arguments
  end

  def to_h
    dos = [
      { keyword: 'do' }
    ]

    dos << handle_prefix(prefix) if prefix
    dos << { symbol: '.' } if prefix
    dos << {identifier: function.literal}
    dos << { symbol: '(' }
    dos << { expressionList: form_arguments }
    dos << { symbol: ')' }
    dos << { symbol: ';' }

    { do_statement: dos.flatten }
  end

  def form_arguments
    return '' if arguments.empty?

    arguments.map do |a|
      handle_expression(a)
    end
  end

  def handle_expression(exo)
    term = if exo.term?
      { term: exo.to_h }
    else
      exo.to_h
    end

    { expression:  term}
  end

  def handle_prefix(prefix)
    if prefix.type == Token::THIS
      {keyword: prefix.literal}
    else
      {identifier: prefix.literal}
    end
  end

end