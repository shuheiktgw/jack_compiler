require_relative '../ast_base'

class LetStatement < AstBase

  attr_reader :token, :identifier, :expression

  def initialize(token:, identifier:, expression:)
    @token = token
    @identifier = identifier
    @expression =  expression
  end

  def to_vm(generator)
    generator.write_let(self)
  end
end