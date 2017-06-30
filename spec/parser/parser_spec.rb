require 'spec_helper'

describe Parser do

  describe '#parse_program' do
    let(:lexer) { Lexer.new(input) }
    subject(:results) { Parser.new(lexer).parse_program }

    context 'let statement' do
      let(:input) { 'let variable = ' + expressions }
      let(:token) { Token.new(type: Token::LET, literal: 'let') }
      let(:identifier) { Identifier.new(token: Token.new(type: Token::IDENT, literal: 'variable'), value: 'variable') }

      subject(:first_result) { results.first }

      context 'expression is string constant' do
        let(:expressions) { '"This is a string sentence!!!";' }

        it 'should return StringLiteral' do
          expression = StringLiteral.new(token: Token.new(type: Token::STRING, literal: 'This is a string sentence!!!'), value: 'This is a string sentence!!!')
          expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

          expect(first_result).to eq expected
        end
      end

      context 'expression is integer constant' do
        let(:expressions) { '432718;' }

        it 'should return IntegerLiteral' do
          expression = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '432718'), value: 432718)
          expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

          expect(first_result).to eq expected
        end
      end

      context 'expression is boolean constant' do
        context 'when true' do
          let(:expressions) { 'true;' }

          it 'should return BooleanLiteral with true' do
            expression = BooleanLiteral.new(token: Token.new(type: Token::TRUE, literal: 'true'), value: true)
            expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

            expect(first_result).to eq expected
          end
        end

        context 'when false' do
          let(:expressions) { 'false;' }

          it 'should return BooleanLiteral with true' do
            expression = BooleanLiteral.new(token: Token.new(type: Token::FALSE, literal: 'false'), value: false)
            expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

            expect(first_result).to eq expected
          end
        end
      end
    end
  end
end