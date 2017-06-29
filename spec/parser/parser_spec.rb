require 'spec_helper'

describe Parser do

  describe '#parse_program' do
    let(:lexer) { Lexer.new(input) }
    subject(:results) { Parser.new(lexer).parse_program }

    context 'let statement' do
      let(:input) { 'let variable = ' + expression }
      subject(:first_result) { results.first }

      context 'expression is string constant' do
        let(:expression) { '"This is a string sentence!!!;"' }

        it 'should return StringLiteral' do
          expect(first_result.token).to eq Token::LET
          expect(first_result.identifier).to eq Identifier.new(token: Token::STRING, value: 'variable')
          expect(first_result.expression).to eq StringLiteral.new(token: Token::STRING, value: 'This is a string sentence!!!')
        end
      end
    end
  end
end