class Token
  TOKEN_TYPE = {
    ILLEGAL: 'ILLEGAL',
    EOF: 'EOF',
    IDENT: 'IDENT',
    INT: 'INT',
    ASSIGN: '=',
    PLUS: '+',
    MINUS: '-',
    BANG: '!',
    ASTERISK: '*',
    SLASH: '/',
    LT: '<',
    GT: '>',
    EQ: '::',
    NOT_EQ: '!:',
    COMMA: ',',
    SEMICOLON: ';',
    LPAREN: '(',
    RPAREN: ')',
    LBRACE: '{',
    RBRACE: '}',
    FUNCTION: 'FUNCTION',
    LET: 'LET',
    TRUE: 'TRUE',
    FALSE: 'FALSE',
    IF: 'IF',
    ELSE: 'ELSE',
    RETURN: 'RETURN'
  }

  attr_reader :token_type, :literal

  def initialize(token_type:, literal:)
    @token_type = token_type
    @literal = literal
  end

end