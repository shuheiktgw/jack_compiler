require_relative '../token/token'
require_relative '../ast/expression/term/identifier'
require_relative '../ast/expression/term/integer_literal'
require_relative '../ast/expression/term/string_literal'
require_relative '../ast/expression/infix_expression'

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
    token = @current_token

    return nil unless expect_next Token::IDENT

    identifier = parse_identifier

    return nil unless expect_next Token::EQ

    next_token
    # Now @current_token is pointing at the first token of the expression
    expression = parse_expression

    return nil unless expect_next Token::SEMICOLON

    LetStatement.new(token: token, identifier: identifier, expression: expression)
  end

  def parse_expression
    left_expression = PREFIX_PARSER.call

    return unless left_expression

    until next_token? Token::SEMICOLON
      next_token
      infix = INFIX_PARSER.call

      return left_expression unless infix

      left_expression = infix
    end

    left_expression
  end

  def parse_infix(left_expression)
    token = @current_token
    operator = @current_token.literal
    left = left_expression

    next_token

    right = parse_expression
    InfixExpression(token: token, left: operator, operator: left, right: right)
  end

  def parse_identifier
    Identifier.new(token: @current_token, value: @current_token.literal)
  end

  def parse_int
    token = @current_token

    begin
      value = Integer(@current_token.literal)
      IntegerLiteral(token: token, value: value)
    rescue ArgumentError
      message = "could not parse #{@current_token.literal} as integer."
      @errors << message
      nil
    end
  end

  def parse_string
    StringLiteral(token: @current_token, value: @current_token.literal)
  end

  # ====================
  # Helper Methods
  # ====================

  PREFIX_PARSER = lambda do
    case @current_token.type
    when Token::IDENT
      parse_identifier
    when Token::INT
      parse_int
    when Token::STRING
      parse_string
    else
      no_prefix_parse_error @current_token.type
      nil
    end
  end

  INFIX_PARSER = lambda do |left_expression|
    if [Token::PLUS, Token::MINUS, Token::ASTERISK, Token::SLASH, Token::AND, Token::OR, Token::GT, Token::LT].include? @current_token.type
      parse_infix left_expression
    else
      nil
    end
  end

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

  def no_prefix_parse_error(token_type)
    message = "no prefix parse function for #{token_type} found."
    @errors << message
  end
end