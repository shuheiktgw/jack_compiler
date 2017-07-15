require 'spec_helper'

describe PrefixExpression do
  let(:prefix_expression) { PrefixExpression.new(token: 'token', operator: operator, right: right) }

  describe '#to_h / #to_xml' do
    # token is not important here so I just mocked it using string.
    subject(:hash) { prefix_expression.to_h }
    subject(:xml) { prefix_expression.to_xml }

    context 'operator is ~' do
      let(:operator) { '~' }

      context 'right is int' do
        let(:right) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '432718'), value: 432718) }

        it do
          expected = {
            expression: [
              {symbol: '~'},
              {
                term: {
                  integerConstant: 432718
                }
              }
            ]
          }

          expect(hash).to eq expected
        end

        it do
          expected = '<expression><symbol>~</symbol><term><integerConstant>432718</integerConstant></term></expression>'
          expect(xml).to eq expected
        end
      end

      context 'right is identifier' do
        let(:right) { Identifier.new(token: Token.new(type: Token::IDENT, literal: 'variable'), value: 'variable') }

        it do
          expected = {
            expression: [
              {symbol: '~'},
              { term: [ { identifier: 'variable' } ] }
            ]
          }

          expect(hash).to eq expected
        end

        it do
          expected = '<expression><symbol>~</symbol><term><identifier>variable</identifier></term></expression>'
          expect(xml).to eq expected
        end
      end
    end
  end
end