class VarDeclaration < AstBase
  attr_reader :token, :type, :identifier

  def initialize(token:, type:, identifier:)
    @token = token
    @type = type
    @identifier = identifier
  end
end