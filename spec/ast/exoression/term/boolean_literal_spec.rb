require 'spec_helper'
require_relative '../../../to_vm_helper'

describe BooleanLiteral do
  include ToVmHelper

  setup_generator
  subject{ File.read(path) }

  describe '#to_vm' do

    before do
      BooleanLiteral.new(token: 'token', value: value).to_vm(generator)
    end

    context 'when value is true' do
      let(:value) { true }

      it do
        expected ='''push constant 1
not
'''

        is_expected.to eq expected
      end
    end

    context 'when value is false' do
      let(:value) { false }

      it do
        expected = "push constant 0\n"

        is_expected.to eq expected
      end
    end
  end
end