require_relative '../ast_base'

class MethodDeclaration < AstBase
  attr_reader :token, :type, :method_name, :parameters, :body

  def initialize(token:, type:, method_name:, parameters:, body:)
    @token = token
    @type = type
    @method_name = method_name
    @parameters = parameters
    @body = body
  end

  def to_h
    {
      subroutine_dec: [
        {keyword: token.literal},
        parse_type(type),
        {identifier: method_name.literal},
        {symbol: '('},
        {parameter_list: formatted_parameters },
        {symbol: ')'},
        body.to_h
      ].flatten
    }
  end

  def formatted_parameters
    if parameters.length < 2
      parameters.map(&:to_h).flatten
    else
      ps = parameters.map{|p| [p.to_h, {symbol: ','}] }.flatten
      # Need to delete last {symbol: ','}
      ps.delete_at(-1)
      ps
    end
  end

  def parse_type(token)
    if token.type == Token::IDENT
      return { identifier: token.literal }
    end

    { keyword: token.literal }
  end

end