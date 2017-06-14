require_relative '../token/token'

class Lexer

  def initialize(input)
    @input = input # expect to receive return value from File.read('file_path'), which is just a series of strings
    @position = 0
    @read_position = 0
    @char = ''

    read_char
  end

  def next_token
    eat_white_spaces

    token = case @char
    when '='
      Token.new(token_type: Token::EQ, literal: @char)
    when '~'
      Token.new(token_type: Token::NOT, literal: @char)
    when '+'
      Token.new(token_type: Token::PLUS, literal: @char)
    when '-'
      Token.new(token_type: Token::MINUS, literal: @char)
    when '*'
      Token.new(token_type: Token::ASTERISK, literal: @char)
    when '/'
      Token.new(token_type: Token::SLASH, literal: @char)
    when '<'
      Token.new(token_type: Token::LT, literal: @char)
    when '>'
      Token.new(token_type: Token::GT, literal: @char)
    when '&'
      Token.new(token_type: Token::AND, literal: @char)
    when '|'
      Token.new(token_type: Token::OR, literal: @char)
    when '.'
      Token.new(token_type: Token::PERIOD, literal: @char)
    when ','
      Token.new(token_type: Token::COMMA, literal: @char)
    when ';'
      Token.new(token_type: Token::SEMICOLON, literal: @char)
    when '('
      Token.new(token_type: Token::LPAREN, literal: @char)
    when ')'
      Token.new(token_type: Token::RPAREN, literal: @char)
    when '{'
      Token.new(token_type: Token::LBRACE, literal: @char)
    when '}'
      Token.new(token_type: Token::RBRACE, literal: @char)
    when '['
      Token.new(token_type: Token::LBRACK, literal: @char)
    when ']'
      Token.new(token_type: Token::RBRACK, literal: @char)
    when 'EOF'
      Token.new(token_type: Token::EOF, literal: '')
    end

    read_char

    token
  end


  private

  def read_char
    if @read_position >= @input.length
      @char = Token::EOF
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