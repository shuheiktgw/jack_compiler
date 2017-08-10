require 'spec_helper'
require './spec/to_vm_helper'

describe LetStatement do
  include ToVmHelper

  setup_generator
  subject{ File.read(path) }

  describe '#to_vm' do
    let(:identifier) { Identifier.new(token: 'mock', value: 'someIdent', index: index) }
    let(:symbol_segment) { 'local' }
    let(:symbol_index) { 0 }

    before do
      LetStatement.new(token: 'token_mock', identifier: identifier, expression: IntegerLiteral.new(token: 'some_token', value: 1)).to_vm(generator)
    end

    context 'without index' do
      let(:index) { nil }

      it do
        expected = '''push constant 1
pop local 0
'''
        is_expected.to eq expected
      end
    end

    context 'with index' do
      let(:index) { IntegerLiteral.new(token: 'some_token', value: 10) }

      it do
        expected = '''push local 0
push constant 10
add
push constant 1
pop temp 0
pop pointer 1
push temp 0
pop that 0
'''
        is_expected.to eq expected
      end
    end
  end
end