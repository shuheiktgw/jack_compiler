class ReturnStatement < AstBase

  RETURN_XML = 'returnStatement'.freeze

  def initialize(token:, expression:)
    @token = token
    @return_value = expression
  end

  def to_h
    {
      RETURN_XML => @return_value.to_h
    }
  end
end