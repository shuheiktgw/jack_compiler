require 'ostruct'
require_relative '../token/token'

module SymbolTable
  class LocalTable

    attr_reader :class_name, :method_name, :rows

    ARGUMENT_TYPE = 'argument'
    LOCAL_TYPE = 'local'

    def initialize(class_name, method)
      @class_name = class_name
      @method_name = method.method_name.literal
      @rows = parse_method(method)
    end

    def find(variable_name)
      rows.find{ |r| r.name == variable_name }
    end

    private

    def parse_method(method)
      arguments = parse_arguments(method)
      locals = method.body.vars.map.with_index{ |v, i| create_row(name: v.identifier.literal, type: v.type.literal, segment: LOCAL_TYPE,  index: i) }

      [arguments, locals].flatten
    end

    def parse_arguments(method)
      if method.token.type == Token::METHOD
        args = method.parameters.map.with_index(1) { |a, i| create_row(name: a.identifier.literal, type: a.type.literal, segment: ARGUMENT_TYPE,  index: i) }
        [hidden_argument, args]
      else
        method.parameters.map.with_index { |a, i| create_row(name: a.identifier.literal, type: a.type.literal, segment: ARGUMENT_TYPE,  index: i) }
      end
    end

    def hidden_argument
      create_row(
        name: 'this',
        type: class_name,
        segment: ARGUMENT_TYPE,
        index: 0
      )
    end

    def create_row(name:, type:, segment:, index:)
      OpenStruct.new(
        name: name,
        type: type,
        segment: segment,
        index: index
      )
    end
  end
end