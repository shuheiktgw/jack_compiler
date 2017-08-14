module SymbolTable
  class ClassTable

    attr_reader :rows

    def initialize(klass)
      @rows = parse_vars(klass)
    end

    def find(variable_name, raise_error = true)
      r = rows.find{ |r| r.name == variable_name }

      unless r
        raise "Uninitialized variable is given: #{variable_name}" if raise_error
        return false
      end

      r
    end

    def count_field_vars
      rows.select{ |r| r.segment == 'this' }.count
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
        segment: translate_declaration(var.token.literal),
        index: index
      )
    end

    def translate_declaration(declaration_type)
      case declaration_type
      when 'field'
        'this'
      else
        declaration_type
      end
    end
  end
end