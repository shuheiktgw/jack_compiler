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
      let(:variables) {[ClassVarDeclaration.new(token: Token.new(type: Token::STATIC, literal: 'static'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifiers: identifiers)]}

      context 'one identifier' do
        let(:identifiers) {[Token.new(type: Token::IDENT, literal: 'i')]}

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
        let(:identifiers) {[Token.new(type: Token::IDENT, literal: 'i'), Token.new(type: Token::IDENT, literal: 'j')]}

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
      let(:variables) {[ClassVarDeclaration.new(token: Token.new(type: Token::FIELD, literal: 'field'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifiers: identifiers)]}

      context 'one identifier' do
        let(:identifiers) {[Token.new(type: Token::IDENT, literal: 'i')]}

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
        let(:identifiers) {[Token.new(type: Token::IDENT, literal: 'i'), Token.new(type: Token::IDENT, literal: 'j')]}

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
      let(:static) {[ClassVarDeclaration.new(token: Token.new(type: Token::STATIC, literal: 'static'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifiers: static_identifiers)]}
      let(:field) {[ClassVarDeclaration.new(token: Token.new(type: Token::FIELD, literal: 'field'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifiers: field_identifiers)]}
      let(:static_identifiers) {[Token.new(type: Token::IDENT, literal: 'a'), Token.new(type: Token::IDENT, literal: 'b')]}
      let(:field_identifiers) {[Token.new(type: Token::IDENT, literal: 'i'), Token.new(type: Token::IDENT, literal: 'j')]}

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