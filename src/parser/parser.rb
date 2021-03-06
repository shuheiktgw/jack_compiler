require_relative '../token/token'
require_relative '../ast/program'
require_relative '../ast/declaration/class_declaration'
require_relative '../ast/declaration/method_body'
require_relative '../ast/declaration/method_declaration'
require_relative '../ast/declaration/parameter'
require_relative '../ast/declaration/var_declaration'
require_relative '../ast/expression/term/boolean_literal'
require_relative '../ast/expression/term/identifier'
require_relative '../ast/expression/term/integer_literal'
require_relative '../ast/expression/term/null_literal'
require_relative '../ast/expression/term/string_literal'
require_relative '../ast/expression/term/this_literal'
require_relative '../ast/expression/term/function_call'
require_relative '../ast/expression/group_expression'
require_relative '../ast/expression/infix_expression'
require_relative '../ast/expression/prefix_expression'
require_relative '../ast/statement/block_statement'
require_relative '../ast/statement/do_statement'
require_relative '../ast/statement/if_statement'
require_relative '../ast/statement/let_statement'
require_relative '../ast/statement/return_statement'
require_relative '../ast/statement/while_statement'
require 'pry-byebug'

class Parser

  def initialize(lexer)
    @lexer = lexer
    @errors = []

    # Set @current_token and @next_token
    next_token
    next_token
  end

  def parse_program
    classes = []

    token = @current_token

    while @current_token.type != Token::EOF
      break unless @errors.empty?

      case @current_token.type
      when Token::CLASS
        klass = parse_class
        classes << klass if klass
      else
        message = "Unexpected class top level token #{@current_token.type} has been detected."
        @errors << message
      end
    end

    if @errors.size > 0
      raise ParseError, error_message
    end

    Program.new(token: token, classes: classes)
  end

  # ====================
  # Parsers
  # ====================

  def parse_class
    token = @current_token

    expect_next Token::IDENT

    class_name = @current_token

    expect_next Token::LBRACE

    next_token

    vars = []
    methods = []

    while @current_token.type != Token::RBRACE
      return unless @errors.empty?

      if @current_token.type == Token::EOF
        unexpected_eof_error
        return
      end

      case @current_token.type
      when Token::STATIC, Token::FIELD
        vars << parse_class_var
      when Token::CONSTRUCTOR, Token::FUNCTION, Token:: METHOD
        methods << parse_method
      else
        message = "Unexpected class level token #{@current_token.type} has been detected."
        @errors << message
        return
      end
    end

    next_token

    ClassDeclaration.new(token: token, class_name: class_name, variables: vars.flatten, methods: methods.flatten)
  end

  def parse_class_var
    parse_vars true
  end

  def parse_method
    token = @current_token

    return unless expect_next Token::TYPE_TOKENS

    type = @current_token

    return unless expect_next Token::IDENT

    identifier = @current_token

    return unless expect_next Token::LPAREN

    parameters = parse_parameters

    return unless expect_next Token::LBRACE

    next_token

    body = parse_method_body

    next_token

    MethodDeclaration.new(token: token, type: type, method_name: identifier, parameters: parameters, body: body)
  end

  def parse_parameters
    parameters = []

    if next_token? Token::RPAREN
      next_token
      return parameters
    end

    parameters << parse_parameter

    while next_token? Token::COMMA
      next_token

      parameters << parse_parameter
    end

    return unless expect_next Token::RPAREN

    parameters
  end

  def parse_parameter
    return unless expect_next Token::TYPE_TOKENS

    type = @current_token

    return unless expect_next Token::IDENT

    identifier = @current_token

    Parameter.new(type: type, identifier: identifier)
  end

  def parse_method_body
    token = @current_token
    vars = parse_var_declarations
    stmts = parse_statements

    MethodBody.new(token: token, vars: vars, statements: stmts)
  end

  def parse_var_declarations
    parse_vars false
  end

  def parse_vars(is_class)
    var_declarations = []

    targets = if is_class
      [Token::STATIC, Token::FIELD]
    else
      [Token::VAR]
    end

    while targets.include? @current_token.type
      var = parse_var_declaration
      var_declarations << var if var

      next_token
    end

    var_declarations.flatten
  end

  def parse_var_declaration
    token = @current_token

    # Checking type
    return unless expect_next Token::TYPE_TOKENS

    type = @current_token

    return unless expect_next Token::IDENT

    vars = []

    vars << VarDeclaration.new(token: token, type: type, identifier: @current_token)

    while next_token? Token::COMMA
      next_token

      return unless expect_next Token::IDENT

      vars << VarDeclaration.new(token: token, type: type, identifier: @current_token)
    end

    return unless expect_next Token::SEMICOLON

    vars
  end

  def parse_statements
    statements = []
    while @current_token.type != Token::RBRACE
      if @current_token.type == Token::EOF
        unexpected_eof_error
        return
      end

      stmt = parse_statement
      stmt ? statements << stmt : return

      next_token
    end

    statements
  end

  def parse_statement
    case @current_token.type
    when Token::LET
      parse_let_statement
    when Token::RETURN
      parse_return_statement
    when Token::IF
      parse_if_statement
    when Token::WHILE
      parse_while_statement
    when Token::DO
      parse_do_statement
    else
      message = "Unknown statement is detected. Cannot parse token type #{@current_token.type}."
      @errors << message
      nil
    end
  end

  def parse_let_statement
    token = @current_token

    return unless expect_next Token::IDENT

    identifier = parse_identifier

    return unless expect_next Token::EQ

    next_token
    # Now @current_token is pointing at the first token of the expression
    expression = parse_expression

    return unless expect_next Token::SEMICOLON

    LetStatement.new(token: token, identifier: identifier, expression: expression)
  end

  def parse_return_statement
    token = @current_token

    next_token

    return_value = if @current_token.type == Token::SEMICOLON
      nil
    else
      exp = parse_expression
      return unless expect_next Token::SEMICOLON

      exp
    end

    ReturnStatement.new(token: token, return_value: return_value)
  end

  def parse_if_statement
    token = @current_token

    return unless expect_next Token::LPAREN

    next_token
    condition = parse_expression

    return unless expect_next Token::RPAREN
    return unless expect_next Token::LBRACE

    consequence = parse_block_statement

    alternative = if next_token? Token::ELSE
      next_token

      return unless expect_next Token::LBRACE
      parse_block_statement
    end

    IfStatement.new(token: token, condition: condition, consequence: consequence, alternative: alternative)
  end

  def parse_do_statement
    token = @current_token

    return unless expect_next Token::IDENT, Token::THIS

    prefix = parse_function_prefix

    function = @current_token

    return unless expect_next Token::LPAREN

    arguments = parse_arguments

    return unless expect_next Token::SEMICOLON

    DoStatement.new(token: token, prefix: prefix, function: function, arguments: arguments)
  end

  def parse_function_prefix
    extract_prefix = -> () do
      if next_token? Token::PERIOD
        prefix = @current_token
        next_token
        next_token

        prefix
      else
        nil
      end
    end

    if @current_token.type == Token::IDENT
      return extract_prefix.call
    end


    if @current_token.type == Token::THIS
      return extract_prefix.call
    end

    nil
  end

  def parse_arguments
    arguments = []

    next_token

    if @current_token.type == Token::RPAREN
      return arguments
    end

    arguments << parse_expression

    while next_token? Token::COMMA
      next_token
      next_token
      arguments << parse_expression
    end

    return unless expect_next Token::RPAREN

    arguments
  end

  def parse_while_statement
    token = @current_token

    return unless expect_next Token::LPAREN

    next_token
    condition = parse_expression

    return unless expect_next Token::RPAREN
    return unless expect_next Token::LBRACE

    consequence = parse_block_statement

    WhileStatement.new(token: token, condition: condition, consequence: consequence)
  end

  def parse_block_statement
    token = @current_token

    next_token
    statements = []

    # TODO(ktgw): This part is very very very vulnerable... should strengthen somehow
    while @current_token.type != Token::RBRACE && @current_token.type != Token::ELSE
      stmt = parse_statement
      statements << stmt if stmt

      if next_token? Token::EOF
        unexpected_eof_error
        return
      end

      next_token
    end

    BlockStatement.new(token: token, statements: statements)
  end

  def parse_expression
    expression = handle_prefix

    return unless expression

    until (next_token? Token::SEMICOLON) || (next_token? Token::COMMA) || (next_token? Token::RPAREN) || (next_token? Token::RBRACK)
      if next_token? Token::EOF
        unexpected_eof_error
        return
      end

      next_token

      infix = handle_infix expression

      return expression unless infix

      expression = infix
    end

    expression
  end

  def parse_prefix
    token = @current_token
    operator = @current_token.literal

    next_token

    right = parse_expression

    PrefixExpression.new(token: token, operator: operator, right: right)
  end

  def parse_group
    next_token

    expression = parse_expression

    return unless expect_next Token::RPAREN

    GroupExpression.new(expression: expression)
  end

  def parse_infix(left_expression)
    token = @current_token
    left = left_expression
    operator = @current_token.literal

    next_token

    right = parse_expression
    InfixExpression.new(token: token, left: left, operator: operator, right: right)
  end

  def parse_function_call
    token = @current_token

    # Consider into with prefix and without prefix
    prefix = if next_token? Token::PERIOD
      next_token
      return unless expect_next Token::IDENT
      token
    else
      nil
    end

    function = @current_token

    return unless expect_next Token::LPAREN

    arguments = parse_arguments

    FunctionCall.new(token: token, prefix: prefix, function: function, arguments: arguments)
  end

  def parse_identifier
    token = @current_token
    value = @current_token.literal

    index = if next_token? Token::LBRACK
      next_token
      next_token

      e = parse_expression
      expect_next Token::RBRACK

      e
    end

    Identifier.new(token: token, value: value, index: index)
  end

  def parse_int
    token = @current_token

    begin
      value = Integer(@current_token.literal)
      IntegerLiteral.new(token: token, value: value)
    rescue ArgumentError
      message = "could not parse #{@current_token.literal} as integer."
      @errors << message
      nil
    end
  end

  def parse_string
    StringLiteral.new(token: @current_token, value: @current_token.literal)
  end

  def parse_boolean
    literal = @current_token.literal

    if literal == 'true'
      BooleanLiteral.new(token: @current_token, value: true)
    elsif literal == 'false'
      BooleanLiteral.new(token: @current_token, value: false)
    else
      message = "could not parse #{@current_token.literal} as boolean."
      @errors << message

      nil
    end
  end

  def error_message
    @errors.join "\n"
  end

  def next_token
    @current_token = @next_token
    @next_token = @lexer.next_token
  end

  private

  # ====================
  # Helper Methods
  # ====================

  def handle_prefix
    case @current_token.type
    when Token::IDENT
      if (next_token? Token::PERIOD) || (next_token? Token::LPAREN)
        parse_function_call
      else
        parse_identifier
      end
    when Token::INT
      parse_int
    when Token::STRING
      parse_string
    when Token::TRUE, Token::FALSE
      parse_boolean
    when Token::MINUS
      parse_prefix
    when Token::NOT
      parse_prefix
    when Token::LPAREN
      parse_group
    when Token::THIS
      ThisLiteral.new
    when Token::NULL
      NullLiteral.new
    else
      no_prefix_parse_error @current_token.type
      nil
    end
  end

  def handle_infix(left_expression)
    if [Token::PLUS, Token::MINUS, Token::ASTERISK, Token::SLASH, Token::AND, Token::OR, Token::EQ, Token::GT, Token::LT].include? @current_token.type
      parse_infix left_expression
    else
      nil
    end
  end

  def expect_next(*token_types)
    types = token_types.flatten
    if types.map { |tt| next_token? tt }.any?
      next_token
      true
    else
      next_token_error types.join ' or '
      false
    end
  end

  def next_token?(token_type)
    @next_token.type == token_type
  end

  def next_token_error(token_type)
    message = "expected next token to be #{token_type}, got #{@next_token.type} instead."
    @errors << message
  end

  def no_prefix_parse_error(token_type)
    message = "no prefix parse function for #{token_type} found."
    @errors << message
  end

  def unexpected_eof_error
    @errors << 'unexpected EOF has gotten.'
  end

  class ParseError < StandardError;
  end
end