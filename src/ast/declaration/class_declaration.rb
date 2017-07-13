class ClassDeclaration < AstBase
  attr_reader :token, :class_name, :variables, :methods

  def initialize(token:, class_name:, variables:, methods:)
    @token = token
    @class_name = class_name
    @variables = variables
    @methods = methods
  end
end