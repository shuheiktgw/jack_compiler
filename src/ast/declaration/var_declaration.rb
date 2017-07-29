require_relative '../ast_base'

class VarDeclaration < AstBase
  attr_reader :token, :type, :identifier

  def initialize(token:, type:, identifier:)
    @token = token
    @type = type
    @identifier = identifier
  end

  def static?
    token.literal == 'static'
  end

  def field?
    token.literal == 'field'
  end
end