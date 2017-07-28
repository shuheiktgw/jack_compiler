require_relative '../ast_base'

class MethodBody < AstBase
  attr_reader :token, :vars, :statements

  def initialize(token:, vars:, statements:)
    @token = token
    @vars = vars
    @statements = statements
  end
end