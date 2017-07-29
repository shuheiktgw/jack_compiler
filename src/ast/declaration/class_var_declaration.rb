require_relative '../ast_base'

class ClassVarDeclaration < AstBase
  attr_reader :token, :type, :identifiers

  def initialize(token:, type:, identifiers:)
    @token = token
    @type = type
    @identifiers = identifiers
  end

  def static?
    token.literal == 'static'
  end

  def field?
    token.literal == 'field'
  end
end