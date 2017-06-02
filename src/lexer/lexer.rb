class Lexer
  def initialize(file)
    @file = file
    @position = 0
    @read_position = 0
    @char = ''
  end
end