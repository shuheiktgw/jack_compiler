require 'spec_helper'

describe InfixExpression do
  # token is not important here so I just mocked it using string.
  let(:infix_expression) { InfixExpression.new(token: 'token', left: left, operator: operator, right: right) }

  describe '#to_h' do
    subject(:hash) { infix_expression.to_h }
    subject(:xml) { infix_expression.to_xml }

    context 'operator is +' do
      let(:operator) { '+' }

      context 'simple two term' do
        let(:left) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '111'), value: 111) }
        let(:right) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '222'), value: 222) }

        it do
          expected = {
            expression: [
              {
                term: {
                  integerConstant: 111
                }
              },
              {symbol: '+'},
              {
                term: {
                  integerConstant: 222
                }
              }
            ]
          }

          expect(hash).to eq expected
        end

        it do
          expected = '<expression><term><integerConstant>111</integerConstant></term><symbol>+</symbol><term><integerConstant>222</integerConstant></term></expression>'
          expect(xml).to eq expected
        end
      end

      context 'simple two term' do
        let(:left) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '111'), value: 111) }
        let(:right){ InfixExpression.new(token: Token.new(type: '+', literal: '+'), left: middle_term, operator: '+', right: right_term) }
        let(:middle_term) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '222'), value: 222) }
        let(:right_term) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '333'), value: 333) }

        it do
          expected = {
            expression: [
              {
                term: {
                  integerConstant: 111
                }
              },
              {symbol: '+'},
              {
                term: {
                  integerConstant: 222
                }
              },
              {symbol: '+'},
              {
                term: {
                  integerConstant: 333
                }
              }
            ]
          }

          expect(hash).to eq expected
        end

        it do
          expected = '<expression><term><integerConstant>111</integerConstant></term><symbol>+</symbol><term><integerConstant>222</integerConstant></term><symbol>+</symbol><term><integerConstant>333</integerConstant></term></expression>'
          expect(xml).to eq expected
        end
      end
    end
  end
end