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
        {keywrod: token.literal},
        parse_type(type),
        {identifier: method_name.literal},
        {symbol: '('},
        {parameter_list: parameters.flatten},
        {symbol: ')'},
        body.to_h
      ]
    }
  end

  def parse_type(token)
    if token.type == Token::IDENT
      return { identifier: token.literal }
    end

    { keyword: token.literal }
  end

end