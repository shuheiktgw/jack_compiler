require_relative '../../ast_base'

class BooleanLiteral < AstBase

  attr_reader :token, :value

  def initialize(token:, value:)
    @token = token
    @value = value
  end

  def term?
    true
  end

  def to_h
    { keyword: @value.to_s }
  end
end