require_relative '../ast_base'

class BlockStatement < AstBase

  attr_reader :token, :statements

  def initialize(token:, statements:)
    @token = token
    @statements = statements
  end

  def to_vm(generator)
    statements.each{ |s| s.to_vm(generator) }
  end

  def ==(other)
    self.token == other.token && self.statements.map.with_index { |s, idx|  s == other.statements[idx]}.all?
  end
end