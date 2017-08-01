require_relative './class_table'
require_relative './local_tables'

module SymbolTable
  class SymbolTable

    def initialize(klass)
      @class_table = ClassTable.new(klass)
      @local_tables = LocalTables.new(klass)
    end
  end
end