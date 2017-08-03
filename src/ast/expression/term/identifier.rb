require_relative '../../ast_base'

class Identifier < AstBase

  attr_reader :token, :value, :index

  def initialize(token:, value:, index: nil)
    @token = token
    @value = value
    @index = index
  end

  def to_vm

  end
end