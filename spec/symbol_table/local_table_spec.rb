require 'spec_helper'
require 'ostruct'

describe SymbolTable::LocalTable do

  describe '#new' do
    subject {SymbolTable::LocalTable.new('TestClass', method).rows}

    let(:method) {double('method')}
    let(:method_token) {double('method_token')}
    let(:method_body) {double('method_body')}

    before do
      allow(method).to receive(:method_name) { 'someMethod' }
      allow(method).to receive(:token) { method_token }
      allow(method_token).to receive(:type) { method_type }
      allow(method).to receive(:parameters) { parameters }
      allow(method).to receive(:body) { method_body }
      allow(method_body).to receive(:vars) { variables }
    end

    context 'parameters' do
      let(:variables) { [] }

      context 'not method' do
        let(:method_type) { 'FUNCTION' }

        context 'zero parameter' do
          let(:parameters) { [] }

          it 'should return no argument' do
            expected = []

            is_expected.to eq expected
          end
        end

        context 'one parameter' do
          let(:parameters) { [Parameter.new(type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))] }

          it 'should return one argument' do
            expected = [
              OpenStruct.new(
                name: 'i',
                type: 'int',
                declaration_type: 'argument',
                index: 0
              )
            ]

            is_expected.to eq expected
          end
        end

        context 'two parameters' do
          let(:parameters) { [
            Parameter.new(type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i')),
            Parameter.new(type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'j'))
          ] }

          it 'should return two arguments' do
            expected = [
              OpenStruct.new(
                name: 'i',
                type: 'int',
                declaration_type: 'argument',
                index: 0
              ),
              OpenStruct.new(
                name: 'j',
                type: 'int',
                declaration_type: 'argument',
                index: 1
              ),
            ]

            is_expected.to eq expected
          end
        end
      end

      context 'method' do
        let(:method_type) { 'METHOD' }

        context 'no parameter' do
          let(:parameters) { [] }

          it 'should return one argument' do
            expected = [
              OpenStruct.new(
                name: 'this',
                type: 'TestClass',
                declaration_type: 'argument',
                index: 0
              )
            ]

            is_expected.to eq expected
          end
        end

        context 'one parameter' do
          let(:parameters) { [Parameter.new(type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))] }

          it 'should return two arguments' do
            expected = [
              OpenStruct.new(
                name: 'this',
                type: 'TestClass',
                declaration_type: 'argument',
                index: 0
              ),
              OpenStruct.new(
                name: 'i',
                type: 'int',
                declaration_type: 'argument',
                index: 1
              )
            ]

            is_expected.to eq expected
          end
        end

        context 'two parameters' do
          let(:parameters) { [
            Parameter.new(type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i')),
            Parameter.new(type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'j'))
          ] }

          it 'should return three arguments' do
            expected = [
              OpenStruct.new(
                name: 'this',
                type: 'TestClass',
                declaration_type: 'argument',
                index: 0
              ),
              OpenStruct.new(
                name: 'i',
                type: 'int',
                declaration_type: 'argument',
                index: 1
              ),
              OpenStruct.new(
                name: 'j',
                type: 'int',
                declaration_type: 'argument',
                index: 2
              ),
            ]

            is_expected.to eq expected
          end
        end
      end
    end
  end
end