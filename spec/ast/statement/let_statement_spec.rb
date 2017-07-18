require 'spec_helper'

describe ReturnStatement do
  let(:let_statement) { LetStatement.new(token: 'token', identifier: Identifier.new(token: Token.new(type: Token::IDENT, literal: 'variable'), value: 'variable'), expression: expression) }

  describe '#to_h / to_xml' do
    subject(:hash) { let_statement.to_h }
    subject(:xml) { let_statement.to_xml }

    context 'return value is int' do
      let(:expression) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1) }

      it do
        expected = {
          letStatement: [
            {keyword: 'let'},
            {identifier: 'variable'},
            {symbol: '='},
            {
              expression: {
              term:
                {
                  integerConstant: 1
                }
              }
            },
            {symbol: ';'}
          ]
        }

        expect(hash).to eq expected
      end

      it do
        expected = '<letStatement><keyword>let</keyword><identifier>variable</identifier><symbol>=</symbol><expression><term><integerConstant>1</integerConstant></term></expression><symbol>;</symbol></letStatement>'
        expect(xml).to eq expected
      end
    end
  end
end