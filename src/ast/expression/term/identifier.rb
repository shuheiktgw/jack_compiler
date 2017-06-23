class Identifier
  IDENT_XML = 'identifier'.freeze

  def initialize(token:, value:)
    @token = token
    @value = value
  end

  def to_h
    {
      IDENT_XML => value
    }
  end
end