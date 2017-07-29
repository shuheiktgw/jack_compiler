module SymbolTable
  class ClassTable

    attr_reader :rows

    def initialize(klass)
      @rows = parse_vars(klass)
    end

    def parse_vars(klass)
      klass.variables.with_index{ |v, i| parse_var v, i }.flatten
    end

    def parse_var(var, index)
      var.map.with_index { |v, i| create_row( v, index + i) }
    end

    def create_row(var, index)
      OpenStruct(
        name: var.identifier.literal,
        type: type.literal,
        declaration_type: token.literal,
        index: index
      )
    end
  end
end