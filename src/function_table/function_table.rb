require 'ostruct'

module FunctionTable
  class FunctionTable

    attr_reader :rows

    def initialize(klasses)
      @rows = klasses.map{ |k| parse_klass(k) }.flatten
    end

    def void?(klass_name:, method_name:)
      r = rows.find{ |row| row.klass_name == klass_name && row.method_name == method_name}
      raise "Unknown method has been specified: #{klass_name}.#{method_name}" unless r

      r.return_type == 'void'
    end

    def method?(klass_name:, method_name:)
      r = rows.find{ |row| row.klass_name == klass_name && row.method_name == method_name}
      raise "Unknown method has been specified: #{klass_name}.#{method_name}" unless r

      r.method_type == 'method'
    end

    def parse_klass(klass)
      klass_name = klass.class_name.literal

      klass.methods.map do |m|
        method_type = m.token.literal
        return_type = m.type.literal
        method_name = m.method_name.literal

        create_row(klass_name: klass_name, method_type: method_type, return_type: return_type, method_name: method_name)
      end
    end

    def create_row(klass_name:, method_type:, return_type:, method_name:)
      OpenStruct.new(
        klass_name: klass_name,
        method_type: method_type,
        return_type: return_type,
        method_name: method_name
      )
    end
  end
end