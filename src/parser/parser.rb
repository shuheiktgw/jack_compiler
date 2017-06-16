class Parser
  def initialize(lexer)
    @lexer = lexer
    @errors = []

    # Set @current_token and @next_token
    next_token
    next_token
  end

  def next_token
    @current_token = @next_token
    @next_token = @lexer.next_token
  end

end