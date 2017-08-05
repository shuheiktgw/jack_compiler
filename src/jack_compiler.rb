require_relative './lexer/lexer'
require_relative './parser/parser'
require_relative './symbol_table/symbol_table'
require_relative './function_table/function_table'
require_relative './generator/generator'
require_relative './loader'
require_relative './writer'

class JackCompiler

  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def execute
    klass_sets = []

    while loader.load_next
      klass = parse_class(loader.content)
      symbol_table = symbol_table(klass)
      writer = writer(vm_path loader.current_file_name)

      klass_sets << {klass: klass, symbol_table: symbol_table, writer: writer}
    end

    function_table = function_table(klass_sets.map{ |ks| ks[:klass] })

    klass_sets.each { |ks| generator(klass: ks[:klass], symbol_table: ks[:symbol_table], function_table: function_table ,writer: ks[:writer]).execute }
  end

  private

  def loader
    @loader ||= Loader.new(file_path)
  end

  def parse_class(content)
    lexer = lexer(content)
    program = parser(lexer).parse_program
    program.classes.first
  end

  def writer(path)
    Writer.new(path)
  end

  def lexer(content)
    Lexer.new(content)
  end

  def parser(lexer)
    Parser.new(lexer)
  end

  def symbol_table(klass)
    SymbolTable::SymbolTable.new(klass)
  end

  def function_table(klasses)
    FunctionTable::FunctionTable.new(klasses)
  end

  def generator(klass:, symbol_table:, function_table:, writer:)
    Generator.new(klass: klass, sybmbol_table: symbol_table, function_table: function_table, writer: writer)
  end

  def vm_path(original)
    original.gsub(/\.jack$/, '.vm')
  end
end