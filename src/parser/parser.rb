require_relative '../token/token'
require_relative '../ast/'

class Parser
  def initialize(lexer)
    @lexer = lexer
    @errors = []

    # Set @current_token and @next_token
    next_token
    next_token
  end

  def parse_program
    statements = []

    while @current_token != Token::EOF
      stmt = parse_statement
      statements << stmt if stmt

      next_token
    end

    statements
  end

  private

  # ====================
  # Parsers
  # ====================

  def parse_statement
    case @current_token.type
    when Token::LET
      parse_let_statement

    end

  end

  def parse_let_statement
    stmt =

  end

  # ====================
  # Helper Methods
  # ====================

  def next_token
    @current_token = @next_token
    @next_token = @lexer.next_token
  end

  def expect_next(token_type)
    if next_token? token_type
      next_token
      true
    else
      next_token_error token_type
      false
    end
  end

  def next_token?(token_type)
    @next_token.type == token_type
  end

  def next_token_error(token_type)
    message = "expected next token to be #{token_type}, got #{@current_token.type} instead."
    @errors << message
  end
end