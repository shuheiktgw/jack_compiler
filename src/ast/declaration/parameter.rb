class Parameter < AstBase
  attr_reader :type, :identifier

  def initialize(type:, identifier:)
    @type = type
    @identifier = identifier
  end

  def to_h
    [
      parse_type(type),
      { identifier: identifier.literal }
    ]

  end

  def parse_type(token)
    if token.type == Token::IDENT
      return { identifier: token.literal }
    end

    { keyword: token.literal }
  end
end