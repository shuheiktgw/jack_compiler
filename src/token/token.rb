class Token
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

  def self.lookup_ident(literal)
    KEYWORDS[literal.to_sym] || IDENT
  end

  def initialize(type:, literal:)
    @type = type
    @literal = literal
  end

end