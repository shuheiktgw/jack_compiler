require 'spec_helper'
require 'ostruct'

describe SymbolTable::ClassTable do

  describe '#new' do
    subject {SymbolTable::ClassTable.new(klass).rows}
    let(:klass) {double('klass')}

    before do
      allow(klass).to receive(:variables) {variables}
    end

    context 'when only static variables' do
      context 'one identifier' do
        let(:variables) do
          [
            VarDeclaration.new(token: Token.new(type: Token::STATIC, literal: 'static'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))
          ]
        end

        it 'should return static' do
          expected = [
            OpenStruct.new(
              name: 'i',
              type: 'int',
              declaration_type: 'static',
              index: 0
            )
          ]

          is_expected.to eq expected
        end
      end

      context 'two identifiers' do
        let(:variables) do
          [
            VarDeclaration.new(token: Token.new(type: Token::STATIC, literal: 'static'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i')),
            VarDeclaration.new(token: Token.new(type: Token::STATIC, literal: 'static'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'j'))
          ]
        end

        it 'should return statics' do
          expected = [
            OpenStruct.new(
              name: 'i',
              type: 'int',
              declaration_type: 'static',
              index: 0
            ),
            OpenStruct.new(
              name: 'j',
              type: 'int',
              declaration_type: 'static',
              index: 1
            )
          ]

          is_expected.to eq expected
        end
      end
    end

    context 'when only filed variables' do
      context 'one identifier' do
        let(:variables) do
          [
            VarDeclaration.new(token: Token.new(type: Token::FIELD, literal: 'field'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))
          ]
        end

        it 'should return field' do
          expected = [
            OpenStruct.new(
              name: 'i',
              type: 'int',
              declaration_type: 'field',
              index: 0
            )
          ]

          is_expected.to eq expected
        end
      end

      context 'two identifiers' do
        let(:variables) do
          [
            VarDeclaration.new(token: Token.new(type: Token::FIELD, literal: 'field'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i')),
            VarDeclaration.new(token: Token.new(type: Token::FIELD, literal: 'field'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'j'))
          ]
        end

        it 'should return statics' do
          expected = [
            OpenStruct.new(
              name: 'i',
              type: 'int',
              declaration_type: 'field',
              index: 0
            ),
            OpenStruct.new(
              name: 'j',
              type: 'int',
              declaration_type: 'field',
              index: 1
            )
          ]

          is_expected.to eq expected
        end
      end
    end

    context 'when statics and fields' do
      let(:variables) { [static, field].flatten }
      let(:static) do
        [
          VarDeclaration.new(token: Token.new(type: Token::STATIC, literal: 'static'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'a')),
          VarDeclaration.new(token: Token.new(type: Token::STATIC, literal: 'static'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'b'))
        ]
      end
      let(:field) do
        [
          VarDeclaration.new(token: Token.new(type: Token::FIELD, literal: 'field'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i')),
          VarDeclaration.new(token: Token.new(type: Token::FIELD, literal: 'field'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'j'))
        ]
      end

      it 'should return statics and fields' do
        expected = [
          OpenStruct.new(
            name: 'a',
            type: 'int',
            declaration_type: 'static',
            index: 0
          ),
          OpenStruct.new(
            name: 'b',
            type: 'int',
            declaration_type: 'static',
            index: 1
          ),
          OpenStruct.new(
            name: 'i',
            type: 'int',
            declaration_type: 'field',
            index: 0
          ),
          OpenStruct.new(
            name: 'j',
            type: 'int',
            declaration_type: 'field',
            index: 1
          )
        ]

        is_expected.to eq expected
      end
    end
  end
end