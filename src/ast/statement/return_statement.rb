class ReturnStatement < AstBase

  def initialize(token:, return_value:)
    @token = token
    @return_value = return_value
  end

  def to_h
    {
      returnStatement: @return_value.to_h
    }
  end
end