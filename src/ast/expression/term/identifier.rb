class Identifier
  def initialize(token:, value:)
    @token = token
    @value = value
  end

  def to_h
    {
      term: {
        identifier: value
      }
    }
  end
end