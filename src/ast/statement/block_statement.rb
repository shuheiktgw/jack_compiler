class BlockStatement < AstBase

  def initialize(token:, statements:)
    @token = token
    @statements = statements
  end
end