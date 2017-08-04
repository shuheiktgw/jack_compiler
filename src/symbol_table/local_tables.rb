require_relative './local_table'
require 'pry-byebug'

module SymbolTable
  class LocalTables

    attr_reader :tables

    def initialize(klass)
      @tables = parse_methods(klass)
    end

    def parse_methods(klass)
      klass.methods.map{ |m| create_table(klass.class_name.literal, m) }
    end

    def create_table(class_name, method)
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