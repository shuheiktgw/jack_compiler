class Token
  attr_reader :token_type, :literal

  ILLEGAL = 'ILLEGAL'
  EOF = 'EOF'
  IDENT = 'IDENT'
  INT = 'INT'

  # Operators
  EQ = '='
  NOT = '~'
  PLUS = '+'
  MINUS = '-'
  ASTERISK = '*'
  SLASH = '/'
  LT = '<'
  GT = '>'
  AND = '&'
  OR = '|'

  # Delimiters
  PERIOD = '.'
  COMMA = ','
  SEMICOLON = ';'
  LPAREN = '('
  RPAREN = ')'
  LBRACE = '{'
  RBRACE = '}'
  LBRACK = '['
  RBRACK = ']'

  FUNCTION = 'FUNCTION'
  LET = 'LET'
  TRUE = 'TRUE'
  FALSE = 'FALSE'
  IF = 'IF'
  ELSE = 'ELSE'
  RETURN = 'RETURN'

  def initialize(token_type:, literal:)
    @token_type = token_type
    @literal = literal
  end

end