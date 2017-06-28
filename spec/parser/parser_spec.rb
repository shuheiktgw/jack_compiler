require 'spec_helper'

describe Parser do

  describe '#parse_program' do
    let(:lexer) { Lexer.new(input) }
    subject(:result) { Parser.new(lexer).parse_program }

    context 'let statement' do
      let(:input) { 'let variable = ' + expression }
      context 'expression is string constant' do
        let(:expression) { '"This is a string sentence!!!"' }

        it 'should return StringLiteral' do
          expect(result.token).to eq Token::LET
          expect(result.identifier.token).to eq Token::IDENT
          expect(result.identifier.value).to eq 'variable'
          expect(result.expression).to eq 'variable'
        end
      end
    end
  end
end