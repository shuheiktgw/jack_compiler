require_relative '../helper/equalable'

class Token
  include Equalable

  attr_reader :type, :literal

  ILLEGAL = 'ILLEGAL'
  EOF = 'EOF'
  IDENT = 'IDENT'
  INT = 'INT'
  STRING = 'STRING'

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

  # Keywords
  CLASS = 'CLASS'
  CONSTRUCTOR = 'CONSTRUCTOR'
  FUNCTION = 'FUNCTION'
  METHOD = 'METHOD'
  FIELD = 'FIELD'
  STATIC = 'STATIC'
  VAR = 'VAR'
  INT_TYPE = 'INT_TYPE'
  CHAR_TYPE = 'CHAR_TYPE'
  BOOLEAN_TYPE = 'BOOLEAN_TYPE'
  STRING_TYPE = 'STRING_TYPE'
  ARRAY_TYPE = 'ARRAY_TYPE'
  VOID_TYPE = 'VOID_TYPE'
  TRUE = 'TRUE'
  FALSE = 'FALSE'
  NULL = 'NULL'
  THIS= 'THIS'
  LET = 'LET'
  DO = 'DO'
  IF = 'IF'
  ELSE = 'ELSE'
  WHILE = 'WHILE'
  RETURN = 'RETURN'

  KEYWORDS = {
    class: CLASS,
    constructor: CONSTRUCTOR,
    function: FUNCTION,
    method: METHOD,
    field: FIELD,
    static: STATIC,
    var: VAR,
    int: INT_TYPE,
    char: CHAR_TYPE,
    boolean: BOOLEAN_TYPE,
    void: VOID_TYPE,
    true: TRUE,
    false: FALSE,
    null: NULL,
    this: THIS,
    let: LET,
    do: DO,
    if: IF,
    else: ELSE,
    while: WHILE,
    return: RETURN
  }

  TYPE_TOKENS = [
    INT_TYPE,
    CHAR_TYPE,
    BOOLEAN_TYPE,
    VOID_TYPE,
    IDENT
  ]

  def self.lookup_ident(literal)
    KEYWORDS[literal.to_sym] || IDENT
  end

  def initialize(type:, literal:)
    @type = type
    @literal = literal
  end

  def type_token?
    TYPE_TOKENS.include? type
  end

  def ==(other)
    self.instance_variables.map {|iv| self.instance_variable_get(iv) == other.instance_variable_get(iv)}.all?
  end
end