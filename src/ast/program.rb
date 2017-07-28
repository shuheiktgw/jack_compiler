require_relative './ast_base'

class Program < AstBase
  attr_reader :token, :classes

  def initialize(token:, classes:)
    @token = token
    @classes = classes
  end
end