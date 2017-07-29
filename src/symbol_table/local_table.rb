require 'ostruct'
require_relative '../token/token'

module SymbolTable
  class LocalTable

    attr_reader :class_name, :method_name, :rows

    ARGUMENT_TYPE = 'argument'
    LOCAL_TYPE = 'local'

    def initialize(class_name, method)
      @class_name = class_name
      @method_name = method.method_name
      @rows = parse_method(method)
    end

    private

    def parse_method(method)
      arguments = parse_arguments(method)
      locals = method.body.vars.map.with_index{ |v, i| create_row(v,LOCAL_TYPE,  i) }

      [arguments, locals].flatten
    end

    def parse_arguments(method)
      if method.token.type == Token::METHOD
        args = method.parameters.map.with_index(1) { |a, i| create_row(a, ARGUMENT_TYPE, i)}
        [hidden_argument, args]
      else
        method.parameters.map.with_index { |a, i| create_row(a, ARGUMENT_TYPE, i)}
      end
    end

    def hidden_argument
      OpenStruct.new(
        name: 'this',
        type: class_name,
        declaration_type: ARGUMENT_TYPE,
        index: 0
      )
    end

    def create_row(var, declaration_type, index)
      OpenStruct.new(
        name: var.identifier.literal,
        type: var.type.literal,
        declaration_type: declaration_type,
        index: index
      )
    end
  end
end