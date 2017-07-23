require_relative '../ast_base'

class ClassVarDeclaration < AstBase
  attr_reader :token, :type, :identifiers

  def initialize(token:, type:, identifiers:)
    @token = token
    @type = type
    @identifiers = identifiers
  end

  def to_h
    {
      class_var_dec: [
        {keyword: token.literal},
        parse_type(type),
        formatted_identifiers,
        {symbol: ';'}
      ].flatten
    }

  end

  def formatted_identifiers
    if identifiers.length < 2
      identifiers.map{|i| {identifier: i.literal} }
    else
      ids = identifiers.map{|i| [{identifier: i.literal}, {symbol: ','}]  }.flatten
      # Need to delete last {symbol: ','}
      ids.delete_at(-1)
      ids
    end
  end

  def parse_type(token)
    if token.type == Token::IDENT
      return { identifier: token.literal }
    end

    { keyword: token.literal }
  end
end