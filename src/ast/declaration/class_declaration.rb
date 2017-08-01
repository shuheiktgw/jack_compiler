require_relative '../ast_base'

class ClassDeclaration < AstBase
  attr_reader :token, :class_name, :variables, :methods

  def initialize(token:, class_name:, variables:, methods:)
    @token = token
    @class_name = class_name
    @variables = variables
    @methods = methods
  end

  def to_vm(generator)
    methods.each{ |m| m.to_vm(generator) }
  end
end