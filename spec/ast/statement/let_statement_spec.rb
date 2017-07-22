require 'spec_helper'

describe LetStatement do
  let(:let_statement) { LetStatement.new(token: 'token', identifier: Identifier.new(token: Token.new(type: Token::IDENT, literal: 'variable'), value: 'variable'), expression: expression) }

  describe '#to_h / to_xml' do
    subject(:hash) { let_statement.to_h }
    subject(:xml) { let_statement.to_xml }

    context 'return value is int' do
      let(:expression) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1) }

      it do
        expected = {
          let_statement: [
            {keyword: 'let'},
            {identifier: 'variable'},
            {symbol: '='},
            {
              expression: {
              term:
                {
                  integer_constant: 1
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

    context 'return value is infix expression' do
      let(:expression){ InfixExpression.new(token: Token.new(type: Token::PLUS, literal: Token::PLUS), left: infix_left, operator: Token::PLUS, right: infix_right) }
      let(:infix_left){ Identifier.new(token: Token.new(type: Token::IDENT, literal: 'indent'), value: 'indent') }
      let(:infix_right){ IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1273'), value: 1273) }

      it do
        expected = {
          let_statement: [
            {keyword: 'let'},
            {identifier: 'variable'},
            {symbol: '='},
            {
              expression: [
                { term:  [ { identifier: 'indent' } ] },
                { symbol: '+'},
                { term: { integer_constant: 1273 } }
              ]
            },
            {symbol: ';'}
          ]
        }

        expect(hash).to eq expected
      end

      it do
        expected = '<letStatement><keyword>let</keyword><identifier>variable</identifier><symbol>=</symbol><expression><term><identifier>indent</identifier></term><symbol>+</symbol><term><integerConstant>1273</integerConstant></term></expression><symbol>;</symbol></letStatement>'
        expect(xml).to eq expected
      end
    end
  end
end

