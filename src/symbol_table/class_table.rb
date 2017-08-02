module SymbolTable
  class ClassTable

    attr_reader :rows

    def initialize(klass)
      @rows = parse_vars(klass)
    end

    def find(variable_name)
      r = rows.find{ |r| r.name == variable_name }
      raise "Uninitialized variable is given: #{variable_name}" unless r

      r
    end

    def parse_vars(klass)
      statics = klass.variables.select{ |v| v.static? }
      fields = klass.variables.select{ |v| v.field? }

      ss = statics.map.with_index { |s, i| create_row(s, i) }
      fs = fields.map.with_index { |f, i| create_row(f, i) }

      [ss, fs].flatten
    end

    def create_row(var, index)
      OpenStruct.new(
        name: var.identifier.literal,
        type: var.type.literal,
        declaration_type: var.token.literal,
        index: index
      )
    end
  end
end