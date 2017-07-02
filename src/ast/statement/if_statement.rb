class IfStatement < AstBase

  attr_reader :token, :condition, :consequence, :alternative

  def initialize(token:, condition:, consequence:, alternative:)
    @token = token
    @condition = condition
    @consequence = consequence
    @alternative = alternative
  end
end