require_relative '../ast_base'

class MethodDeclaration < AstBase
  attr_reader :token, :type, :method_name, :parameters, :body

  def initialize(token:, type:, method_name:, parameters:, body:)
    @token = token
    @type = type
    @method_name = method_name
    @parameters = parameters
    @body = body
  end
end