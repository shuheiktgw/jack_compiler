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

      context 'expression is null constant' do
        let(:expressions) { 'null;' }

        it 'should return BooleanLiteral with true' do
          expression = BooleanLiteral.new(token: Token.new(type: Token::NULL, literal: 'null'), value: nil)
          expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

          expect(first_result).to eq expected
        end
      end

      context 'expression is integer calculation' do

        context 'one digits' do
          let(:left) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1) }
          let(:right) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '2'), value: 2) }

          context 'two terms' do
            let(:expression) { InfixExpression.new(token: Token.new(type: op_type, literal: op), left: left, operator: op, right: right) }
            let(:expected) { LetStatement.new(token: token, identifier: identifier, expression: expression) }
            let(:expressions) { '1' + op + '2' + ';' }

            context 'plus' do
              let(:op) {'+'}
              let(:op_type) {Token::PLUS}

              it do
                expect(first_result).to eq expected
              end
            end

            context 'minus' do
              let(:op) {'-'}
              let(:op_type) {Token::MINUS}

              it do
                expect(first_result).to eq expected
              end
            end

            context 'multiple' do
              let(:op) {'*'}
              let(:op_type) {Token::ASTERISK}

              it do
                expect(first_result).to eq expected
              end
            end

            context 'slash' do
              let(:op) {'/'}
              let(:op_type) {Token::SLASH}

              it do
                expect(first_result).to eq expected
              end
            end
          end

          context 'three terms' do
            let(:middle) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '3'), value: 3) }
            let(:right_expression) { InfixExpression.new(token: Token.new(type: op_type, literal: op), left: middle, operator: op, right: right ) }
            let(:expression) { InfixExpression.new(token: Token.new(type: op_type, literal: op), left: left, operator: op, right: right_expression ) }
            let(:expected) { LetStatement.new(token: token, identifier: identifier, expression: expression) }
            let(:expressions) { '1' + op + '3' + op + '2' + ';' }

            context 'plus' do
              let(:op) {'+'}
              let(:op_type) {Token::PLUS}

              it do
                expect(first_result).to eq expected
              end
            end

            context 'minus' do
              let(:op) {'-'}
              let(:op_type) {Token::MINUS}

              it do
                expect(first_result).to eq expected
              end
            end

            context 'multiple' do
              let(:op) {'*'}
              let(:op_type) {Token::ASTERISK}

              it do
                expect(first_result).to eq expected
              end
            end

            context 'slash' do
              let(:op) {'/'}
              let(:op_type) {Token::SLASH}

              it do
                expect(first_result).to eq expected
              end
            end
          end
        end

        context 'three digits' do
          let(:left) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '111'), value: 111) }
          let(:right) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '222'), value: 222) }

          context 'two terms' do
            let(:expression) { InfixExpression.new(token: Token.new(type: op_type, literal: op), left: left, operator: op, right: right) }
            let(:expected) { LetStatement.new(token: token, identifier: identifier, expression: expression) }
            let(:expressions) { '111' + op + '222' + ';' }

            context 'plus' do
              let(:op) {'+'}
              let(:op_type) {Token::PLUS}

              it do
                expect(first_result).to eq expected
              end
            end

            context 'minus' do
              let(:op) {'-'}
              let(:op_type) {Token::MINUS}

              it do
                expect(first_result).to eq expected
              end
            end

            context 'multiple' do
              let(:op) {'*'}
              let(:op_type) {Token::ASTERISK}

              it do
                expect(first_result).to eq expected
              end
            end

            context 'slash' do
              let(:op) {'/'}
              let(:op_type) {Token::SLASH}

              it do
                expect(first_result).to eq expected
              end
            end
          end

          context 'three terms' do
            let(:middle) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '333'), value: 333) }
            let(:right_expression) { InfixExpression.new(token: Token.new(type: op_type, literal: op), left: middle, operator: op, right: right ) }
            let(:expression) { InfixExpression.new(token: Token.new(type: op_type, literal: op), left: left, operator: op, right: right_expression ) }
            let(:expected) { LetStatement.new(token: token, identifier: identifier, expression: expression) }
            let(:expressions) { '111' + op + '333' + op + '222' + ';' }

            context 'plus' do
              let(:op) {'+'}
              let(:op_type) {Token::PLUS}

              it do
                expect(first_result).to eq expected
              end
            end

            context 'minus' do
              let(:op) {'-'}
              let(:op_type) {Token::MINUS}

              it do
                expect(first_result).to eq expected
              end
            end

            context 'multiple' do
              let(:op) {'*'}
              let(:op_type) {Token::ASTERISK}

              it do
                expect(first_result).to eq expected
              end
            end

            context 'slash' do
              let(:op) {'/'}
              let(:op_type) {Token::SLASH}

              it do
                expect(first_result).to eq expected
              end
            end
          end
        end
      end
    end

    context 'return statement' do
      let(:input) { 'return ' + expressions }
      let(:token) { Token.new(type: Token::RETURN, literal: 'return') }

      subject(:first_result) { results.first }

      context 'expression is string constant' do
        let(:expressions) { '"This is a string sentence!!!";' }

        it 'should return StringLiteral' do
          expression = StringLiteral.new(token: Token.new(type: Token::STRING, literal: 'This is a string sentence!!!'), value: 'This is a string sentence!!!')
          expected = ReturnStatement.new(token: token, return_value: expression)

          expect(first_result).to eq expected
        end
      end

      context 'expression is integer constant' do
        let(:expressions) { '432718;' }

        it 'should return IntegerLiteral' do
          expression = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '432718'), value: 432718)
          expected = ReturnStatement.new(token: token, return_value: expression)

          expect(first_result).to eq expected
        end
      end

      context 'expression is boolean constant' do
        context 'when true' do
          let(:expressions) { 'true;' }

          it 'should return BooleanLiteral with true' do
            expression = BooleanLiteral.new(token: Token.new(type: Token::TRUE, literal: 'true'), value: true)
            expected = ReturnStatement.new(token: token, return_value: expression)

            expect(first_result).to eq expected
          end
        end

        context 'when false' do
          let(:expressions) { 'false;' }

          it 'should return BooleanLiteral with true' do
            expression = BooleanLiteral.new(token: Token.new(type: Token::FALSE, literal: 'false'), value: false)
            expected = ReturnStatement.new(token: token, return_value: expression)

            expect(first_result).to eq expected
          end
        end
      end

      context 'expression is null constant' do
        let(:expressions) { 'null;' }

        it 'should return BooleanLiteral with true' do
          expression = BooleanLiteral.new(token: Token.new(type: Token::NULL, literal: 'null'), value: nil)
          expected = ReturnStatement.new(token: token, return_value: expression)

          expect(first_result).to eq expected
        end
      end
    end

    context 'statement' do
      context 'without else' do
        let(:input) do
          '''
        if(a < 2) {
let test1 = 1 + 2;

return test1;
}
        '''

        end

        let(:token) { Token.new(type: Token::IF, literal: 'if') }
        subject(:first_result) { results.first }

        it do
          condition_left = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'a'), value: 'a')
          condition_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '2'), value: 2)
          condition_op = Token::LT

          expected_condition = InfixExpression.new(token: Token.new(type: condition_op, literal: '<'), left: condition_left, operator: condition_op, right: condition_right)

          # Let statement in the consequence
          consequence_ident = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'test1'), value: 'test1')
          consequence_left = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1)
          consequence_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '2'), value: 2)
          consequence_op = Token::PLUS
          consequence_expression = InfixExpression.new(token: Token.new(type: consequence_op, literal: consequence_op), left: consequence_left, operator: consequence_op, right: consequence_right)
          consequence_let = LetStatement.new(token: Token.new(type: Token::LET, literal: 'let'), identifier: consequence_ident, expression: consequence_expression)

          # Return statement in the consequence
          consequence_return = ReturnStatement.new(token: Token.new(type: Token::RETURN, literal: 'return'), return_value: consequence_ident)

          expected_consequence = BlockStatement.new(token: Token.new(type: Token::LBRACE, literal: '{'), statements: [consequence_let, consequence_return])

          expected = IfStatement.new(token: token, condition: expected_condition, consequence: expected_consequence, alternative: nil)

          expect(first_result).to eq expected
        end
      end

      context 'with else' do
        let(:input) do
          '''
        if(a < 2) {
let test1 = 1 + 2;

return test1;
} else {
let test3 = 3 + 4;

return test3;

}
        '''
        end
        let(:token) { Token.new(type: Token::IF, literal: 'if') }
        subject(:first_result) { results.first }

        it do
          condition_left = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'a'), value: 'a')
          condition_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '2'), value: 2)
          condition_op = Token::LT

          expected_condition = InfixExpression.new(token: Token.new(type: condition_op, literal: '<'), left: condition_left, operator: condition_op, right: condition_right)

          # Let statement in the consequence
          consequence_ident = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'test1'), value: 'test1')
          consequence_left = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1)
          consequence_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '2'), value: 2)
          consequence_op = Token::PLUS
          consequence_expression = InfixExpression.new(token: Token.new(type: consequence_op, literal: consequence_op), left: consequence_left, operator: consequence_op, right: consequence_right)
          consequence_let = LetStatement.new(token: Token.new(type: Token::LET, literal: 'let'), identifier: consequence_ident, expression: consequence_expression)

          # Return statement in the consequence
          consequence_return = ReturnStatement.new(token: Token.new(type: Token::RETURN, literal: 'return'), return_value: consequence_ident)

          expected_consequence = BlockStatement.new(token: Token.new(type: Token::LBRACE, literal: '{'), statements: [consequence_let, consequence_return])

          # Let statement in the alternative
          alternative_ident = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'test3'), value: 'test3')
          alternative_left = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '3'), value: 3)
          alternative_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '4'), value: 4)
          alternative_op = Token::PLUS
          alternative_expression = InfixExpression.new(token: Token.new(type: alternative_op, literal: alternative_op), left: alternative_left, operator: alternative_op, right: alternative_right)
          alternative_let = LetStatement.new(token: Token.new(type: Token::LET, literal: 'let'), identifier: alternative_ident, expression: alternative_expression)

          # Return statement in the alternative
          alternative_return = ReturnStatement.new(token: Token.new(type: Token::RETURN, literal: 'return'), return_value: alternative_ident)

          expected_alternative = BlockStatement.new(token: Token.new(type: Token::LBRACE, literal: '{'), statements: [alternative_let, alternative_return])

          expected = IfStatement.new(token: token, condition: expected_condition, consequence: expected_consequence, alternative: expected_alternative)

          expect(first_result).to eq expected
        end
      end
    end
  end
end