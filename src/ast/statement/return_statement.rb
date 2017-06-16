class ReturnStatement
  def initialize(token:, expression:)
    @token = token
    @return_value = expression
  end
end