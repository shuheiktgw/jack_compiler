require_relative './class_table'
require_relative './local_tables'

module SymbolTable
  class SymbolTable

    def initialize(klass)
      @class_table = ClassTable.new(klass)
      @local_tables = LocalTables.new(klass)
      @current_method = nil
    end

    def notify_method_change(name)
      @current_method = name
    end
  end
end