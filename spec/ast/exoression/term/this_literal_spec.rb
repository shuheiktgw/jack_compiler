require 'spec_helper'
require_relative '../../../to_vm_helper'

describe ThisLiteral do
  include ToVmHelper

  setup_generator
  subject{ File.read(path) }

  describe '#to_vm' do
    it do
      ThisLiteral.new.to_vm(generator)

      expected = "push pointer 0\n"

      is_expected.to eq expected
    end
  end
end