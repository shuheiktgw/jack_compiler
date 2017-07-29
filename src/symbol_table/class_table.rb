require 'ostruct'

module SymbolTable
  class ClassTable

    attr_reader :rows

    def initialize(klass)
      @rows = parse_vars(klass)
    end

    private

    def parse_vars(klass)
      statics = klass.variables.select{ |v| v.static? }
      fields = klass.variables.select{ |v| v.field? }

      ss = statics.map.with_index { |s, i| parse_var(s, i) }
      fs = fields.map.with_index { |f, i| parse_var(f, i) }

      [ss, fs].flatten
    end

    def parse_var(var, index)
      var.identifiers.map.with_index { |identifier, idx| create_row( var, identifier, index + idx) }
    end

    def create_row(var, identifier, index)
      OpenStruct.new(
        name: identifier.literal,
        type: var.type.literal,
        declaration_type: var.token.literal,
        index: index
      )
    end
  end
end