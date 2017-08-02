require_relative './local_table'

module SymbolTable
  class LocalTables

    attr_reader :tables

    def initialize(klass)
      @tables = parse_methods(klass)
    end

    def parse_methods(klass)
      klass.methods.map{ |m| create_table(klass.class_name, m) }
    end

    def create_table(class_name, method)
      t = find_table method
      raise "Duplicate method name is given: #{method}" if t

      LocalTable.new(class_name, method)
    end

    def current_table
      @table
    end

    def set_table(name)
      @table = find_table name
    end

    def find_table(name)
      t = tables.find{ |t| t.method_name == name }
      raise "Unknow method name is given: #{name}" unless t

      t
    end
  end
end