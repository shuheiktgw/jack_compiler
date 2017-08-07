require 'spec_helper'
require_relative '../../../to_vm_helper'

describe NullLiteral do
  include ToVmHelper

  setup_generator
  subject{ File.read(path) }

  describe '#to_vm' do
    it do
      NullLiteral.new.to_vm(generator)

      expected = "push constant 0\n"
      
      is_expected.to eq expected
    end
  end
end