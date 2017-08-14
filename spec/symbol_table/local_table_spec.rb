require 'spec_helper'
require 'ostruct'

describe SymbolTable::LocalTable do
  let(:method) {double('method')}
  let(:method_token) {double('method_token')}
  let(:method_body) {double('method_body')}
  let(:method_name) {double('method_name')}

  before do
    allow(method).to receive(:method_name) { method_name }
    allow(method_name).to receive(:literal) { 'someMethod' }
    allow(method).to receive(:token) { method_token }
    allow(method_token).to receive(:type) { method_type }
    allow(method).to receive(:parameters) { parameters }
    allow(method).to receive(:body) { method_body }
    allow(method_body).to receive(:vars) { variables }
  end

  describe '#new' do
    subject {SymbolTable::LocalTable.new('TestClass', method).rows}

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
                segment: 'argument',
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
                segment: 'argument',
                index: 0
              ),
              OpenStruct.new(
                name: 'j',
                type: 'int',
                segment: 'argument',
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
                segment: 'argument',
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
                segment: 'argument',
                index: 0
              ),
              OpenStruct.new(
                name: 'i',
                type: 'int',
                segment: 'argument',
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
                segment: 'argument',
                index: 0
              ),
              OpenStruct.new(
                name: 'i',
                type: 'int',
                segment: 'argument',
                index: 1
              ),
              OpenStruct.new(
                name: 'j',
                type: 'int',
                segment: 'argument',
                index: 2
              ),
            ]

            is_expected.to eq expected
          end
        end
      end
    end

    context 'variables' do
      let(:method_type) { 'FUNCTION' }
      let(:parameters) { [] }

      context 'single local variable' do
        context 'one identifier' do
          let(:variables) do
            [
              VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))
            ]
          end

          it 'should return local' do
            expected = [
              OpenStruct.new(
                name: 'i',
                type: 'int',
                segment: 'local',
                index: 0
              )
            ]

            is_expected.to eq expected
          end
        end

        context 'two identifiers' do
          let(:variables) do
            [
              VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i')),
              VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'j'))
            ]
          end

          it 'should return locals' do
            expected = [
              OpenStruct.new(
                name: 'i',
                type: 'int',
                segment: 'local',
                index: 0
              ),
              OpenStruct.new(
                name: 'j',
                type: 'int',
                segment: 'local',
                index: 1
              )
            ]

            is_expected.to eq expected
          end
        end
      end

      context 'multiple local variables' do
        context 'one identifier' do
          let(:variables) do
            [
              VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i')),
              VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'a'))
            ]
          end


          it 'should return locals' do
            expected = [
              OpenStruct.new(
                name: 'i',
                type: 'int',
                segment: 'local',
                index: 0
              ),
              OpenStruct.new(
                name: 'a',
                type: 'int',
                segment: 'local',
                index: 1
              )
            ]

            is_expected.to eq expected
          end
        end

        context 'two identifiers' do
          let(:variables) do
            [
              VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i')),
              VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'j')),
              VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'a')),
              VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'b'))
            ]
          end

          it 'should return locals' do
            expected = [
              OpenStruct.new(
                name: 'i',
                type: 'int',
                segment: 'local',
                index: 0
              ),
              OpenStruct.new(
                name: 'j',
                type: 'int',
                segment: 'local',
                index: 1
              ),
              OpenStruct.new(
                name: 'a',
                type: 'int',
                segment: 'local',
                index: 2
              ),
              OpenStruct.new(
                name: 'b',
                type: 'int',
                segment: 'local',
                index: 3
              )
            ]

            is_expected.to eq expected
          end
        end
      end
    end
  end

  describe '#find' do
    let(:variables) do
      [
        VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i')),
        VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'j')),
        VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'a')),
        VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'b'))
      ]
    end

    let(:method_type) { 'FUNCTION' }
    let(:parameters) { [] }

    context 'when valid method name is given' do
      it 'should return valid row' do
        %w(i j a b).each do |var_name|
          row = SymbolTable::LocalTable.new('TestClass', method).find(var_name)
          expect(row.name).to eq var_name
        end
      end
    end

    context 'when invalid method name is given' do
      it 'should return nil' do
        row = SymbolTable::LocalTable.new('TestClass', method).find('invalid_name')
        expect(row).to be_nil
      end
    end
  end

  describe '#count' do
    let(:variables) do
      [
        VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i')),
        VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'j')),
        VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'a')),
        VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'b'))
      ]
    end

    let(:method_type) { 'FUNCTION' }
    let(:parameters) { [] }

    it do
      count = SymbolTable::LocalTable.new('TestClass', method).count_local_vars
      expect(count).to eq 4
    end
  end
end