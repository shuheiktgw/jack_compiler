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
    dos << { expression_list: formatted_arguments }
    dos << { symbol: ')' }
    dos << { symbol: ';' }

    { do_statement: dos.flatten }
  end

  def formatted_arguments
    if arguments.length < 2
      arguments.map{|a| handle_expression(a) }.flatten
    else
      as = arguments.map{|a| [handle_expression(a), {symbol: ','}]  }.flatten
      # Need to delete last {symbol: ','}
      as.delete_at(-1)
      as
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