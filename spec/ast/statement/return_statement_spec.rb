require 'spec_helper'
require './spec/to_vm_helper'

describe LetStatement do
  include ToVmHelper

  setup_generator
  subject{ File.read(path) }

  describe '#to_vm' do
    before do
      ReturnStatement.new(token: 'token', return_value: return_value).to_vm(generator)
    end

    context 'without return value' do
      let(:return_value) { nil }

      it do
        expected = '''return
'''
        is_expected.to eq expected
      end
    end

    context 'with return value' do
      let(:return_value) { IntegerLiteral.new(token: 'some_token', value: 1) }

      it do
        expected = '''push constant 1
return
'''
        is_expected.to eq expected
      end
    end
  end
end