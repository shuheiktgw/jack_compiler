require_relative './lexer/lexer'
require_relative './parser/parser'
require_relative './loader'
require_relative './writer'

class JackCompiler

  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def execute
    while loader.load_next
      lexer = Lexer.new(loader.content)
      parser = Parser.new(lexer)

      program = parser.parse_program
      write(loader.current_file_name, program)
    end
  end

  private

  def loader
    @loader ||= Loader.new(file_path)
  end

  def write(path, program)
    klass = program.classes.first
    Writer.new(hash_path(path), klass.to_h).execute
    Writer.new(xml_path(path), klass.to_xml).execute
  end

  def hash_path(original)
    original.gsub(/\.jack$/, '_hash.rb')
  end

  def xml_path(original)
    original.gsub(/\.jack$/, '.xml')
  end
end