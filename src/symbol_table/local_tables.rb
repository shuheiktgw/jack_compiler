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
      LocalTable.new(class_name, method)
    end
  end
end