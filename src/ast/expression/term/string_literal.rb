require_relative '../../ast_base'

class StringLiteral < AstBase

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
      string_constant: @value
    }
  end
end