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

    def parse_method(method)
      arguments = parse_arguments(method)
      locals = method.body.vars.map.with_index{ |v, i| parse_var(v, i) }

      [arguments, locals].flatten
    end

    def parse_arguments(method)
      if method.token.type == Token::METHOD
        args = method.parameters.map.with_index(1) { |a, i| parse_argument(a, i)}
        [args, hidden_argument]
      else
        method.parameters.map.with_index { |a, i| parse_argument(a, i)}
      end
    end

    def parse_argument(argument, index)
      OpenStruct(
        name: argument.identifier.literal,
        type: argument.type.literal,
        declaration_type: ARGUMENT_TYPE,
        index: index
      )
    end

    def hidden_argument
      OpenStruct(
        name: 'this',
        type: class_name,
        declaration_type: ARGUMENT_TYPE,
        index: 0
      )
    end

    def parse_var(variable, index)
      OpenStruct(
        name: variable.identifier.literal,
        type: variable.type.literal,
        declaration_type: LOCAL_TYPE,
        index: index
      )
    end
  end
end