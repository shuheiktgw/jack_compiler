class DoStatement < AstBase

  attr_reader :token, :function, :arguments

  def initialize(token:, function:, arguments:)
    @token = token
    @function = function
    @arguments = arguments
  end
end