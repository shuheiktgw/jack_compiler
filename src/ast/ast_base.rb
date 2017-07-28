require 'gyoku'
require_relative '../helper/equalable'

class AstBase
  include Equalable

  class UnimplementedError < StandardError; end
end