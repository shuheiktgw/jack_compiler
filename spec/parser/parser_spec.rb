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

    context 'if statement' do
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

    context 'while statement' do
      context 'single line' do
        let(:input) do
          '''
        while(i < 2) {
return test1;
}
        '''
        end

        let(:token) { Token.new(type: Token::WHILE, literal: 'while') }
        subject(:first_result) { results.first }

        it do
          condition_left = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'i'), value: 'i')
          condition_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '2'), value: 2)
          condition_op = Token::LT

          expected_condition = InfixExpression.new(token: Token.new(type: condition_op, literal: '<'), left: condition_left, operator: condition_op, right: condition_right)

          consequence_ident = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'test1'), value: 'test1')
          consequence_return = ReturnStatement.new(token: Token.new(type: Token::RETURN, literal: 'return'), return_value: consequence_ident)

          expected_consequence = BlockStatement.new(token: Token.new(type: Token::LBRACE, literal: '{'), statements: [consequence_return])

          expected = WhileStatement.new(token: token, condition: expected_condition, consequence: expected_consequence)

          expect(first_result.token).to eq token
          expect(first_result.condition).to eq expected_condition
          expect(first_result.consequence.statements.first).to eq consequence_return
          expect(first_result.consequence).to eq expected_consequence
          expect(first_result).to eq expected
        end
      end

      context 'multiple line' do
        let(:input) do
          '''
        while(i = 2) {
let test1 = 1 + 345;
let test2 = test1 * 1123;
return test2;
}
        '''
        end

        let(:token) { Token.new(type: Token::WHILE, literal: 'while') }
        subject(:first_result) { results.first }

        it do
          condition_left = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'i'), value: 'i')
          condition_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '2'), value: 2)
          condition_op = Token::EQ

          expected_condition = InfixExpression.new(token: Token.new(type: condition_op, literal: '='), left: condition_left, operator: condition_op, right: condition_right)

          # First let statement in the consequence
          consequence_ident1 = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'test1'), value: 'test1')
          consequence_left1 = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1)
          consequence_right1 = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '345'), value: 345)
          consequence_op1 = Token::PLUS
          consequence_expression1 = InfixExpression.new(token: Token.new(type: consequence_op1, literal: consequence_op1), left: consequence_left1, operator: consequence_op1, right: consequence_right1)
          consequence_let1 = LetStatement.new(token: Token.new(type: Token::LET, literal: 'let'), identifier: consequence_ident1, expression: consequence_expression1)

          # Second let statement in the consequence
          consequence_ident2 = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'test2'), value: 'test2')
          consequence_right2 = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1123'), value: 1123)
          consequence_op2 = Token::ASTERISK
          consequence_expression2 = InfixExpression.new(token: Token.new(type: consequence_op2, literal: consequence_op2), left: consequence_ident1, operator: consequence_op2, right: consequence_right2)
          consequence_let2 = LetStatement.new(token: Token.new(type: Token::LET, literal: 'let'), identifier: consequence_ident2, expression: consequence_expression2)

          consequence_return = ReturnStatement.new(token: Token.new(type: Token::RETURN, literal: 'return'), return_value: consequence_ident2)

          expected_consequence = BlockStatement.new(token: Token.new(type: Token::LBRACE, literal: '{'), statements: [consequence_let1, consequence_let2, consequence_return])

          expected = WhileStatement.new(token: token, condition: expected_condition, consequence: expected_consequence)

          expect(first_result.token).to eq token
          expect(first_result.condition).to eq expected_condition
          expect(first_result.consequence.statements[0]).to eq consequence_let1
          expect(first_result.consequence.statements[1]).to eq consequence_let2
          expect(first_result.consequence.statements[2]).to eq consequence_return
          expect(first_result.consequence).to eq expected_consequence
          expect(first_result).to eq expected
        end
      end
    end

    context 'parse do statements' do
      context 'simple identifiers' do
        let(:do_token){ Token.new(type: Token::DO, literal: 'do') }
        let(:ident){ Token.new(type: Token::IDENT, literal: 'some_thing') }
        subject(:first_result) { results.first }

        context 'zero parameter' do
          let(:input) do
            '''
            do some_thing()
          '''
          end

          let(:args){ [] }

          it do
            expect(first_result.token).to eq do_token
            expect(first_result.function).to eq ident
            expect(first_result.arguments).to eq args
          end
        end

        context 'one parameter' do
          let(:input) do
            '''
          do some_thing(first)
          '''
          end

          let(:args) { [Identifier.new(token: Token.new(type: Token::IDENT, literal: 'first'), value: 'first')] }

          it do
            expect(first_result.token).to eq do_token
            expect(first_result.function).to eq ident
            expect(first_result.arguments).to eq args
          end
        end

        context 'three parameters' do
          let(:input) do
            '''
          do some_thing(first, second, third)
          '''
          end

          let(:args) do
            first = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'first'), value: 'first')
            second = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'second'), value: 'second')
            third = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'third'), value: 'third')

            [first, third, second]
          end

          it do
            expect(first_result.token).to eq do_token
            expect(first_result.function).to eq ident
            expect(first_result.arguments).to eq args
          end
        end
      end
    end
  end
end