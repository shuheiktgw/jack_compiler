require 'spec_helper'
require_relative '../../../to_vm_helper'

describe StringLiteral do
  include ToVmHelper

  setup_generator

  describe '#to_vm' do

    it 'test' do
      generator
    end
  end
end