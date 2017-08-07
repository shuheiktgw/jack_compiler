require 'spec_helper'
require_relative '../../../to_vm_helper'

describe IntegerLiteral do
  include ToVmHelper

  setup_generator
  subject{ File.read(path) }

  describe '#to_vm' do

    context 'when constant is 1' do
      it do
        IntegerLiteral.new(token: 'token', value: 1).to_vm(generator)

        expected = "push constant 1\n"

        is_expected.to eq expected
      end
    end

    context 'when constant is 10' do
      it do
        IntegerLiteral.new(token: 'token', value: 10).to_vm(generator)

        expected = "push constant 10\n"

        is_expected.to eq expected
      end
    end
  end
end