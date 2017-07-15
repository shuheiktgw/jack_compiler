require_relative '../token/token'
require 'pry-byebug'

class Lexer

  # FIXME Use buffer instead.
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
      Token.new(type: Token::EQ, literal: @char)
    when '~'
      Token.new(type: Token::NOT, literal: @char)
    when '+'
      Token.new(type: Token::PLUS, literal: @char)
    when '-'
      Token.new(type: Token::MINUS, literal: @char)
    when '*'
      Token.new(type: Token::ASTERISK, literal: @char)
    when '/'
      return eat_comments if peer_char == '/' || peer_char == '*'

      Token.new(type: Token::SLASH, literal: @char)
    when '<'
      Token.new(type: Token::LT, literal: @char)
    when '>'
      Token.new(type: Token::GT, literal: @char)
    when '&'
      Token.new(type: Token::AND, literal: @char)
    when '|'
      Token.new(type: Token::OR, literal: @char)
    when '.'
      Token.new(type: Token::PERIOD, literal: @char)
    when ','
      Token.new(type: Token::COMMA, literal: @char)
    when ';'
      Token.new(type: Token::SEMICOLON, literal: @char)
    when '('
      Token.new(type: Token::LPAREN, literal: @char)
    when ')'
      Token.new(type: Token::RPAREN, literal: @char)
    when '{'
      Token.new(type: Token::LBRACE, literal: @char)
    when '}'
      Token.new(type: Token::RBRACE, literal: @char)
    when '['
      Token.new(type: Token::LBRACK, literal: @char)
    when ']'
      Token.new(type: Token::RBRACK, literal: @char)
    when '"'
      Token.new(type: Token::STRING, literal: read_string)
    when 'EOF'
      Token.new(type: Token::EOF, literal: '')
    else
      if letter? @char
        literal = read_identifier
        type = Token.lookup_ident(literal)

        Token.new(type: type, literal: literal)
      elsif digit? @char
        Token.new(type: Token::INT, literal: read_number)
      else
        Token.new(type: Token::ILLEGAL, literal: @char)
      end
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

  def eat_comments
    case peer_char
    when '/'
      until @char == "\n"
        read_char
      end

      # Skip last \n
      read_char
    when '*'
      until @char == '*' && peer_char == '/'
        read_char
      end

      # Skip last */
      read_char
      read_char
    else
      raise "Unexpected character #{peer_char} is given."
    end

    next_token
  end

  def read_string
    read_char

    position = @position

    while @char != '"'
      read_char
    end

    @input[position...@position]
  end

  def read_identifier
    position = @position

    # first digit of variable name should be a letter
    read_char if letter? peer_char

    while (letter? peer_char) || (digit? peer_char)
      read_char
    end

    @input[position..@position]
  end

  def read_number
    position = @position

    while digit? peer_char
      read_char
    end

    @input[position..@position]
  end

  def letter?(ch)
    ch =~ /^[a-zA-Z_]$/
  end

  def digit?(ch)
    ch =~ /^[0-9]$/
  end

  def peer_char
    @input[@read_position]
  end
end