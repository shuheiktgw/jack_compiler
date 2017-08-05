require_relative './class_table'
require_relative './local_tables'

module SymbolTable
  class SymbolTable

    attr_reader :class_table, :local_tables

    def initialize(klass)
      @class_table = ClassTable.new(klass)
      @local_tables = LocalTables.new(klass)
    end

    def find(variable_name, raise_error = true)
      local_table.find(variable_name) || class_table.find(variable_name, raise_error)
    end

    def notify_method_change(name)
      local_tables.set_table(name)
    end

    def local_table
      local_tables.current_table
    end
  end
end