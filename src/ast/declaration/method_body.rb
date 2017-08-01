require_relative '../ast_base'

class MethodBody < AstBase
  attr_reader :token, :vars, :statements

  def initialize(token:, vars:, statements:)
    @token = token
    @vars = vars
    @statements = statements
  end

  def to_vm(generator)
    statements.each{ |s| s.to_vm(generator) }
  end
end