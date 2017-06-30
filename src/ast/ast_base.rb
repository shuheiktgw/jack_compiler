require_relative '../helper/equalable'

class AstBase
  include Equalable

  class UnimplementedError < StandardError; end

  def to_h
    raise UnimplementedError, "You have to override #to_h in its child class, #{self.class.name}"
  end
end