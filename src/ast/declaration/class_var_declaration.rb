class ClassVarDeclaration < AstBase
  attr_reader :token, :type, :identifier

  def initialize(token:, type:, identifier:)
    @token = token
    @type = type
    @identifier = identifier
  end

  def to_h
    {
      ClassvarDec: [
        {keyword: 'var'},
        parse_type(type),
        {identifier: identifier.literal},
        {symbol: ';'}
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