require_relative '../../ast_base'

class IntegerLiteral < AstBase

  attr_reader :token, :value

  def initialize(token:, value:)
    @token = token
    @value = value
  end

  def term?
    true
  end

  def to_h
    {
      integer_constant: @value
    }
  end
end