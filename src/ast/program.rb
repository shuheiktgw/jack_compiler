class Program < AstBase
  attr_reader :token, :classes

  def initialize(token:, classes:)
    @token = token
    @classes = classes
  end

  def to_h
    classes.map(&:to_h)
  end
end