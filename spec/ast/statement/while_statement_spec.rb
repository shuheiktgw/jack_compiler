require 'spec_helper'
require './spec/to_vm_helper'

describe WhileStatement do
  include ToVmHelper

  setup_generator
  subject{ File.read(path) }

  describe '#to_vm' do
    before do
      WhileStatement.new(token: 'token', condition: condition, consequence: consequence).to_vm(generator)
    end

    context 'without return value' do
      let(:true_term) { BooleanLiteral.new(token: Token.new(type: Token::TRUE, literal: 'true'), value: true) }
      let(:condition) { true_term }
      let(:consequence) { ReturnStatement.new(token: 'token', return_value: true_term) }

      it do
        expected = '''label TestClass0
push constant 1
not
not
if-goto TestClass1
push constant 1
not
return
goto TestClass0
label TestClass1
'''
        is_expected.to eq expected
      end
    end
  end
end