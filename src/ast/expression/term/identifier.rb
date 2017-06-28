class Identifier

  attr_reader :token, :value

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

  def ==(other)
    self.instance_variables.map {|iv| self.instance_variable_get(iv) == other.instance_variable_get(iv)}.all?
  end
end