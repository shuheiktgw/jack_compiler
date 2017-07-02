class BlockStatement < AstBase

  attr_reader :token, :statements

  def initialize(token:, statements:)
    @token = token
    @statements = statements
  end

  def ==(other)
    self.token == other.token && self.statements.map.with_index { |s, idx|  s == other.statements[idx]}.all?
  end
end