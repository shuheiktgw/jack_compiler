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

  def to_vm(generator)
    generator.write_function(method_type: token.literal, method_name: method_name.literal, number: parameters.count)

    if type.literal == 'void'
      s = body.statements.pop
      raise "last statement of #{method_name.literal} should be return, but got: #{s.token.literal}" if s.token.literal != 'return'

      body.to_vm(generator)
      generator.write_push(segment: 'constant', index: 0)
      generator.write_return
      generator.write_pop(segment: 'temp', index: 0)
    else
      body.to_vm(generator)
    end
  end
end