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
      subroutineDec: [
        {keywrod: token.literal},
        parse_type(type),
        {identifier: method_name.literal},
        {symbol: '('},
        {parameterList: parameters.flatten},
        {symbol: ')'}
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