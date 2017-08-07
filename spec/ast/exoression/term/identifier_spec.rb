require 'spec_helper'
require_relative '../../../to_vm_helper'

describe Identifier do
  include ToVmHelper

  setup_generator
  subject{ File.read(path) }

  describe '#to_vm' do

    context 'without index' do
      let(:symbol_segment) { 'argument' }
      let(:symbol_index) { 1 }

      it do
        Identifier.new(token: 'token', value: 'someValue').to_vm(generator)

        expected = "push argument 1\n"

        is_expected.to eq expected
      end
    end

    context 'with index' do
      let(:symbol_segment) { 'argument' }
      let(:symbol_index) { 1 }

      it do
        Identifier.new(token: 'token', value: 'someValue', index: IntegerLiteral.new(token: 'token', value: 100)).to_vm(generator)

        expected = '''push argument 1
push constant 100
add
pop pointer 1
push that 0
'''

        is_expected.to eq expected
      end
    end
  end
end