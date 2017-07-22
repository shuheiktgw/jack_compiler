require_relative '../ast_base'

class MethodBody < AstBase
  attr_reader :token, :vars, :statements

  def initialize(token:, vars:, statements:)
    @token = token
    @vars = vars
    @statements = statements
  end

  def to_h
    {
      subroutineBody: [
        {symbol: '{'},
        vars.map(&:to_h).flatten,
        {statements: statements.map(&:to_h).flatten},
        {symbol: '}'}
      ].flatten
    }
  end
end