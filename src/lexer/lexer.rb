require_relative '../token/token'

class Lexer

  EOF = 'EOF'

  def initialize(input)
    @input = input # expect to receive return value of File.read('file_path')
    @position = 0
    @read_position = 0
    @char = ''

    read_char
  end

  def next_token
    eat_white_spaces

    token = case @char
    when '='
      Token.new(token_type: Token.TOKEN_TYPE[:ASSIGN], literal: @char)
    when '+'
      Token.new(token_type: Token.TOKEN_TYPE[:PLUS], literal: @char)
    when '-'
      Token.new(token_type: Token.TOKEN_TYPE[:MINUS], literal: @char)
    when '*'
      Token.new(token_type: Token.TOKEN_TYPE[:ASTERISK], literal: @char)
    when '/'
      Token.new(token_type: Token.TOKEN_TYPE[:SLASH], literal: @char)
    end


  end


  private

  def read_char
    if @read_position >= @input.length
      @char = EOF
    else
      @char = @input[@read_position]
    end

    @position = @read_position
    @read_position += 1
  end

  def eat_white_spaces
    white_spaces = [' ', "\t", "\n", "\r"]

    while white_spaces.include? @char
      read_char
    end
  end
end