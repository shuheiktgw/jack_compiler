class BlockStatement < AstBase

  attr_reader :token, :statements

  def initialize(token:, statements:)
    @token = token
    @statements = statements
  end

  def to_h
    { statements: statements.map(&:to_h) }
  end

  def ==(other)
    self.token == other.token && self.statements.map.with_index { |s, idx|  s == other.statements[idx]}.all?
  end
end