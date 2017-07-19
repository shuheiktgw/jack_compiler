require 'gyoku'
require_relative '../helper/equalable'

class AstBase
  include Equalable

  class UnimplementedError < StandardError; end

  def term?
    false
  end

  def to_h
    raise UnimplementedError, "You have to override #to_h in its child class, #{self.class.name}"
  end

  def to_xml
    Gyoku.xml(self.to_h, unwrap: true)
  end
end