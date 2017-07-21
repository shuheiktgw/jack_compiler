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
        vars,
        statements,
        {symbol: '}'}
      ].flatten
    }
  end
end