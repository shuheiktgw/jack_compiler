class AstBase

  class UnimplementedError < StandardError; end

  def to_h
    raise UnimplementedError, "You have to override #to_h in its child class, #{self.class.name}"
  end

  private

  def ==(other)
    self.instance_variables.map {|iv| self.instance_variable_get(iv) == other.instance_variable_get(iv)}.all?
  end
end