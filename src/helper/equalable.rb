module Equalable
  def ==(other)
    self.instance_variables.map {|iv| self.instance_variable_get(iv) == other.instance_variable_get(iv)}.all?
  end
end