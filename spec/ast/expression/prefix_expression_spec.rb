require 'spec_helper'

describe PrefixExpression do
  let(:prefix_expression) { PrefixExpression.new(token: 'token', operator: operator, right: right) }

  describe '#to_h / #to_xml' do
    subject(:hash) { prefix_expression.to_h }
    subject(:xml) { prefix_expression.to_xml }

    context 'operator is ~' do
      let(:operator) { '~' }

      context 'right is int' do
        let(:right) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '432718'), value: 432718) }

        it do
          expected = [
            {symbol: '~'},
            {
              term: {
                integer_constant: 432718
              }
            }
          ]

          expect(hash).to eq expected
        end

        it do
          expected = '<symbol>~</symbol><term><integerConstant>432718</integerConstant></term>'
          expect(xml).to eq expected
        end
      end

      context 'right is identifier' do
        let(:right) { Identifier.new(token: Token.new(type: Token::IDENT, literal: 'variable'), value: 'variable') }

        it do
          expected = [
            {symbol: '~'},
            { term: [ { identifier: 'variable' } ] }
          ]

          expect(hash).to eq expected
        end

        it do
          expected = '<symbol>~</symbol><term><identifier>variable</identifier></term>'
          expect(xml).to eq expected
        end
      end

      context 'right is group' do
        let(:right) {GroupExpression.new(expression: infix_expression)}
        let(:infix_expression) {InfixExpression.new(token: Token.new(type: '=', literal: '='), left: left_infix, operator: '=', right: right_infix)}
        let(:left_infix) {Identifier.new(token: Token.new(type: Token::IDENT, literal: 'key'), value: 'key')}
        let(:right_infix) {IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '0'), value: 0)}

        it do
          expect(xml).to eq '<symbol>~</symbol><term><symbol>(</symbol><expression><term><identifier>key</identifier></term><symbol>=</symbol><term><integerConstant>0</integerConstant></term></expression><symbol>)</symbol></term>'
        end
      end
    end
  end
end