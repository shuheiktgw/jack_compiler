class Parameter < AstBase
  attr_reader :type, :identifier

  def initialize(type:, identifier:)
    @type = type
    @identifier = identifier
  end
end