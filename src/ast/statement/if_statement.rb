class IfStatement < AstBase

  def initialize(token:, condition:, consequence:, alternative:)
    @token = token
    @condition = condition
    @consequence = consequence
    @alternative = alternative
  end
end