require 'spec_helper'
require './spec/to_vm_helper'

describe IfStatement do
  include ToVmHelper

  setup_generator
  subject{ File.read(path) }

  describe '#to_vm' do
    before do
      IfStatement.new(token: 'token', condition: condition, consequence: consequence, alternative: alternative).to_vm(generator)
    end

    context 'without return value' do
      let(:true_term) { BooleanLiteral.new(token: Token.new(type: Token::TRUE, literal: 'true'), value: true) }
      let(:condition) { true_term }
      let(:consequence) { ReturnStatement.new(token: 'token', return_value: true_term) }

      context 'without alternative' do
        let(:alternative) { nil }


        it do
          expected = '''push constant 1
neg
not
if-goto TestClass1
push constant 1
neg
return
goto TestClass1
label TestClass1
'''
          is_expected.to eq expected
        end
      end

      context 'with alternative' do
        let(:alternative) { ReturnStatement.new(token: 'token', return_value: true_term) }

        it do
          expected = '''push constant 1
neg
not
if-goto TestClass0
push constant 1
neg
return
goto TestClass1
label TestClass0
push constant 1
neg
return
label TestClass1
'''
          is_expected.to eq expected
        end
      end
    end
  end
end