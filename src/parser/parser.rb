require_relative '../token/token'

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

  def next_token
    @current_token = @next_token
    @next_token = @lexer.next_token
  end

  def parse_statement
    
  end

end