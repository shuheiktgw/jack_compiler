require 'spec_helper'

# Remaining Tasks
# TODO: add abnormal test cases for parse_class
# TODO: add top level parser

describe Parser do
  let(:lexer) { Lexer.new(input) }
  let(:parser) { Parser.new(lexer) }

  describe '#parse_class' do
    subject(:klass) { parser.parse_class }

    context 'empty' do
      let(:input) do
        '''
        class SomeClass {
}
        '''
      end

      it do
        expected = ClassDeclaration.new(token: Token.new(type: Token::CLASS, literal: 'class'), class_name: Token.new(type: Token::IDENT, literal: 'SomeClass'), variables: [], methods: [])
        expect(klass.token).to eq expected.token
        expect(klass.class_name).to eq expected.class_name
        expect(klass.variables).to eq expected.variables
        expect(klass.methods).to eq expected.methods
        expect(parser.error_message).to be_empty
      end
    end

    context 'with constructor' do
      let(:input) do
        '''
        class SomeClass {
constructor Square new(int Ax, int Ay, int Asize) {
      let x = Ax;
      let y = Ay;
      let size = Asize;
      do draw();
      return this;
   }
}
        '''
      end

      it do
        expected = ClassDeclaration.new(token: Token.new(type: Token::CLASS, literal: 'class'), class_name: Token.new(type: Token::IDENT, literal: 'SomeClass'), variables: [], methods: [])
        expect(klass.token).to eq expected.token
        expect(klass.class_name).to eq expected.class_name
        expect(klass.variables).to be_empty
        expect(klass.methods).not_to be_empty
        expect(parser.error_message).to be_empty
      end
    end

    context 'with function' do
      let(:input) do
        '''
        class SomeClass {
function void test() {
        var int i, j;
        var String s;
        var Array a;
        if (false) {
            let s = "string constant";
            let s = null;
            let a[1] = a[2];
        }
        else {
            let i = i * (-j);
            let j = j / (-2);
            let i = i | j;
        }
        return;
    }
}
        '''
      end

      it do
        expected = ClassDeclaration.new(token: Token.new(type: Token::CLASS, literal: 'class'), class_name: Token.new(type: Token::IDENT, literal: 'SomeClass'), variables: [], methods: [])
        expect(klass.token).to eq expected.token
        expect(klass.class_name).to eq expected.class_name
        expect(klass.variables).to be_empty
        expect(klass.methods).not_to be_empty
        expect(parser.error_message).to be_empty
      end
    end

    context 'with function' do
      let(:input) do
        '''
        class SomeClass {
function void test() {
        var int i, j;
        var String s;
        var Array a;
        if (false) {
            let s = "string constant";
            let s = null;
            let a[1] = a[2];
        }
        else {
            let i = i * (-j);
            let j = j / (-2);
            let i = i | j;
        }
        return;
    }
}
        '''
      end

      it do
        expected = ClassDeclaration.new(token: Token.new(type: Token::CLASS, literal: 'class'), class_name: Token.new(type: Token::IDENT, literal: 'SomeClass'), variables: [], methods: [])
        expect(klass.token).to eq expected.token
        expect(klass.class_name).to eq expected.class_name
        expect(klass.variables).to be_empty
        expect(klass.methods).not_to be_empty
        expect(parser.error_message).to be_empty
      end
    end

    context 'with method' do
      let(:input) do
        '''
        class SomeClass {
method void moveRight() {
      if ((x + size) < 510) {
         do Screen.setColor(false);
         do Screen.drawRectangle(x, y, x + 1, y + size);
         let x = x + 2;
         do Screen.setColor(true);
         do Screen.drawRectangle((x + size) - 1, y, x + size, y + size);
      }
      return;
   }
}
        '''
      end

      it do
        expected = ClassDeclaration.new(token: Token.new(type: Token::CLASS, literal: 'class'), class_name: Token.new(type: Token::IDENT, literal: 'SomeClass'), variables: [], methods: [])
        expect(klass.token).to eq expected.token
        expect(klass.class_name).to eq expected.class_name
        expect(klass.variables).to be_empty
        expect(klass.methods).not_to be_empty
        expect(parser.error_message).to be_empty
      end
    end

    context 'with field' do
      let(:input) do
        '''
        class SomeClass {
field int x, y;
field int size;
}
        '''
      end

      it do
        expected = ClassDeclaration.new(token: Token.new(type: Token::CLASS, literal: 'class'), class_name: Token.new(type: Token::IDENT, literal: 'SomeClass'), variables: [], methods: [])
        expect(klass.token).to eq expected.token
        expect(klass.class_name).to eq expected.class_name
        expect(klass.variables).not_to be_empty
        expect(klass.methods).to be_empty
        expect(parser.error_message).to be_empty
      end
    end

    context 'with static' do
      let(:input) do
        '''
        class SomeClass {
static int x, y;
static int size;
}
        '''
      end

      it do
        expected = ClassDeclaration.new(token: Token.new(type: Token::CLASS, literal: 'class'), class_name: Token.new(type: Token::IDENT, literal: 'SomeClass'), variables: [], methods: [])
        expect(klass.token).to eq expected.token
        expect(klass.class_name).to eq expected.class_name
        expect(klass.variables).not_to be_empty
        expect(klass.methods).to be_empty
        expect(parser.error_message).to be_empty
      end
    end
  end

  describe '#parse_class_var' do
    subject(:vars) { parser.parse_class_var }

    context 'static' do
      context 'single var declaration' do
        context 'int' do
          let(:input) { 'static int i;' }

          it do
            expected = VarDeclaration.new(token: Token.new(type: Token::STATIC, literal: 'static'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))
            expect(vars.first).to eq expected
            expect(parser.error_message).to be_empty
          end
        end

        context 'char' do
          let(:input) { 'static char someChar;' }

          it do
            expected = VarDeclaration.new(token: Token.new(type: Token::STATIC, literal: 'static'), type: Token.new(type: Token::CHAR_TYPE, literal: 'char'), identifier: Token.new(type: Token::IDENT, literal: 'someChar'))
            expect(vars.first).to eq expected
            expect(parser.error_message).to be_empty
          end
        end

        context 'user defined class' do
          let(:input) { 'static SomeClass userDefinedInstance;' }

          it do
            expected = VarDeclaration.new(token: Token.new(type: Token::STATIC, literal: 'static'), type: Token.new(type: Token::IDENT, literal: 'SomeClass'), identifier: Token.new(type: Token::IDENT, literal: 'userDefinedInstance'))
            expect(vars.first).to eq expected
            expect(parser.error_message).to be_empty
          end
        end

        context 'multiple' do
          let(:input) { 'static int i1, i2;' }

          it do
            first = VarDeclaration.new(token: Token.new(type: Token::STATIC, literal: 'static'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i1'))
            second = VarDeclaration.new(token: Token.new(type: Token::STATIC, literal: 'static'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i2'))
            expect(vars[0]).to eq first
            expect(vars[1]).to eq second
            expect(parser.error_message).to be_empty
          end
        end
      end

      context 'multiple var declarations' do
        let(:input) do
          '' '
            static int i;
static char c;
static SomeClass someVar;
' ''
        end

        it do
          expected_first = VarDeclaration.new(token: Token.new(type: Token::STATIC, literal: 'static'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))
          expected_second = VarDeclaration.new(token: Token.new(type: Token::STATIC, literal: 'static'), type: Token.new(type: Token::CHAR_TYPE, literal: 'char'), identifier: Token.new(type: Token::IDENT, literal: 'c'))
          expected_third = VarDeclaration.new(token: Token.new(type: Token::STATIC, literal: 'static'), type: Token.new(type: Token::IDENT, literal: 'SomeClass'), identifier: Token.new(type: Token::IDENT, literal: 'someVar'))
          expect(vars[0]).to eq expected_first
          expect(vars[1]).to eq expected_second
          expect(vars[2]).to eq expected_third
          expect(parser.error_message).to be_empty
        end
      end
    end

    context 'field' do
      context 'single var declaration' do
        context 'int' do
          let(:input) { 'field int i;' }

          it do
            expected = VarDeclaration.new(token: Token.new(type: Token::FIELD, literal: 'field'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))
            expect(vars.first).to eq expected
            expect(parser.error_message).to be_empty
          end
        end

        context 'char' do
          let(:input) { 'field char someChar;' }

          it do
            expected = VarDeclaration.new(token: Token.new(type: Token::FIELD, literal: 'field'), type: Token.new(type: Token::CHAR_TYPE, literal: 'char'), identifier: Token.new(type: Token::IDENT, literal: 'someChar'))
            expect(vars.first).to eq expected
            expect(parser.error_message).to be_empty
          end
        end

        context 'user defined class' do
          let(:input) { 'field SomeClass userDefinedInstance;' }

          it do
            expected = VarDeclaration.new(token: Token.new(type: Token::FIELD, literal: 'field'), type: Token.new(type: Token::IDENT, literal: 'SomeClass'), identifier: Token.new(type: Token::IDENT, literal: 'userDefinedInstance'))
            expect(vars.first).to eq expected
            expect(parser.error_message).to be_empty
          end
        end

        context 'multiple' do
          let(:input) { 'field int i1, i2;' }

          it do
            first = VarDeclaration.new(token: Token.new(type: Token::FIELD, literal: 'field'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i1'))
            second = VarDeclaration.new(token: Token.new(type: Token::FIELD, literal: 'field'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i2'))
            expect(vars[0]).to eq first
            expect(vars[1]).to eq second
            expect(parser.error_message).to be_empty
          end
        end
      end

      context 'multiple var declarations' do
        let(:input) do
          '' '
            field int i;
field char c;
field SomeClass someVar;
' ''
        end

        it do
          expected_first = VarDeclaration.new(token: Token.new(type: Token::FIELD, literal: 'field'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))
          expected_second = VarDeclaration.new(token: Token.new(type: Token::FIELD, literal: 'field'), type: Token.new(type: Token::CHAR_TYPE, literal: 'char'), identifier: Token.new(type: Token::IDENT, literal: 'c'))
          expected_third = VarDeclaration.new(token: Token.new(type: Token::FIELD, literal: 'field'), type: Token.new(type: Token::IDENT, literal: 'SomeClass'), identifier: Token.new(type: Token::IDENT, literal: 'someVar'))
          expect(vars[0]).to eq expected_first
          expect(vars[1]).to eq expected_second
          expect(vars[2]).to eq expected_third
          expect(parser.error_message).to be_empty
        end
      end
    end
  end

  describe '#parse_parameters' do
    subject(:method) { parser.parse_method }
    let(:input) do
      """
      #{method_type} void someMethod(int i) {
  return;
}
      """
    end

    context 'constructor' do
      let(:method_type) { 'constructor' }

      it do
        expect(method.token).to eq Token.new(type: Token::CONSTRUCTOR, literal: 'constructor')
        expect(method.type).to eq Token.new(type: Token::VOID_TYPE, literal: 'void')
        expect(method.parameters).to eq [Parameter.new(type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))]
        expect(method.body).to eq MethodBody.new(token: Token.new(type: Token::RETURN, literal: 'return'), vars: [], statements: [ReturnStatement.new(token: Token.new(type: Token::RETURN, literal: 'return'), return_value: nil)])
        expect(parser.error_message).to be_empty
      end
    end

    context 'function' do
      let(:method_type) { 'function' }

      it do
        expect(method.token).to eq Token.new(type: Token::FUNCTION, literal: 'function')
        expect(method.type).to eq Token.new(type: Token::VOID_TYPE, literal: 'void')
        expect(method.parameters).to eq [Parameter.new(type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))]
        expect(method.body).to eq MethodBody.new(token: Token.new(type: Token::RETURN, literal: 'return'), vars: [], statements: [ReturnStatement.new(token: Token.new(type: Token::RETURN, literal: 'return'), return_value: nil)])
        expect(parser.error_message).to be_empty
      end
    end

    context 'method' do
      let(:method_type) { 'method' }

      it do
        expect(method.token).to eq Token.new(type: Token::METHOD, literal: 'method')
        expect(method.type).to eq Token.new(type: Token::VOID_TYPE, literal: 'void')
        expect(method.parameters).to eq [Parameter.new(type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))]
        expect(method.body).to eq MethodBody.new(token: Token.new(type: Token::RETURN, literal: 'return'), vars: [], statements: [ReturnStatement.new(token: Token.new(type: Token::RETURN, literal: 'return'), return_value: nil)])
        expect(parser.error_message).to be_empty
      end
    end
  end

  describe '#parse_parameters' do
    subject{ parser.parse_parameters }

    context 'blank' do
      let(:input) {'()'}

      it do
        is_expected.to be_empty
        expect(parser.error_message).to be_empty
      end
    end

    context 'one parameter' do
      let(:input) {'(int i)'}

      it do
        param = Parameter.new(type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))
        expected = [param]

        is_expected.to eq expected
        expect(parser.error_message).to be_empty
      end
    end

    context 'two parameters' do
      let(:input) {'(int i, String str)'}

      it do
        param_i = Parameter.new(type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))
        param_str = Parameter.new(type: Token.new(type: Token::IDENT, literal: 'String'), identifier: Token.new(type: Token::IDENT, literal: 'str'))
        expected = [param_i, param_str]

        is_expected.to eq expected
        expect(parser.error_message).to be_empty
      end
    end

    context 'three parameters' do
      let(:input) {'(int i, String str, char chr)'}

      it do
        param_i = Parameter.new(type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))
        param_str = Parameter.new(type: Token.new(type: Token::IDENT, literal: 'String'), identifier: Token.new(type: Token::IDENT, literal: 'str'))
        param_chr = Parameter.new(type: Token.new(type: Token::CHAR_TYPE, literal: 'char'), identifier: Token.new(type: Token::IDENT, literal: 'chr'))
        expected = [param_i, param_str, param_chr]

        is_expected.to eq expected
        expect(parser.error_message).to be_empty
      end
    end
  end

  describe '#parse_var_declarations' do
    subject(:vars) { parser.parse_var_declarations }

    context 'single var declaration' do
      context 'int' do
        let(:input) { 'var int i;' }

        it do
          expected = VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))
          expect(vars.first).to eq expected
          expect(parser.error_message).to be_empty
        end
      end

      context 'char' do
        let(:input) { 'var char someChar;' }

        it do
          expected = VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::CHAR_TYPE, literal: 'char'), identifier: Token.new(type: Token::IDENT, literal: 'someChar'))
          expect(vars.first).to eq expected
          expect(parser.error_message).to be_empty
        end
      end

      context 'user defined class' do
        let(:input) { 'var SomeClass userDefinedInstance;' }

        it do
          expected = VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::IDENT, literal: 'SomeClass'), identifier: Token.new(type: Token::IDENT, literal: 'userDefinedInstance'))
          expect(vars.first).to eq expected
          expect(parser.error_message).to be_empty
        end
      end

      context 'multiple' do
        let(:input) { 'var int i1, i2;' }

        it do
          first = VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i1'))
          second = VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i2'))
          expect(vars[0]).to eq first
          expect(vars[1]).to eq second
          expect(parser.error_message).to be_empty
        end
      end
    end

    context 'multiple var declarations' do
      let(:input) do
        '' '
            var int i;
var char c;
var SomeClass someVar;
' ''
      end

      it do
        expected_first = VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::INT_TYPE, literal: 'int'), identifier: Token.new(type: Token::IDENT, literal: 'i'))
        expected_second = VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::CHAR_TYPE, literal: 'char'), identifier: Token.new(type: Token::IDENT, literal: 'c'))
        expected_third = VarDeclaration.new(token: Token.new(type: Token::VAR, literal: 'var'), type: Token.new(type: Token::IDENT, literal: 'SomeClass'), identifier: Token.new(type: Token::IDENT, literal: 'someVar'))
        expect(vars[0]).to eq expected_first
        expect(vars[1]).to eq expected_second
        expect(vars[2]).to eq expected_third
        expect(parser.error_message).to be_empty
      end
    end
  end

  describe '#parse_statements' do
    context 'normal' do
      subject(:results) { parser.parse_statements }
      subject(:first_result) { results.first }

      context 'let statement' do
        let(:token) { Token.new(type: Token::LET, literal: 'let') }

        context 'plain indentifier' do
          let(:identifier) { Identifier.new(token: Token.new(type: Token::IDENT, literal: 'variable'), value: 'variable') }
          let(:input) { "let variable = #{ expressions } }"}

          context 'expression is string constant' do
            let(:expressions) { '"This is a string sentence!!!";' }

            it 'should return StringLiteral' do
              expression = StringLiteral.new(token: Token.new(type: Token::STRING, literal: 'This is a string sentence!!!'), value: 'This is a string sentence!!!')
              expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

              expect(first_result).to eq expected
              expect(parser.error_message).to be_empty
            end
          end

          context 'expression is integer constant' do
            let(:expressions) { '432718;' }

            it 'should return IntegerLiteral' do
              expression = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '432718'), value: 432718)
              expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

              expect(first_result).to eq expected
              expect(parser.error_message).to be_empty
            end
          end

          context 'expression is boolean constant' do
            context 'when true' do
              let(:expressions) { 'true;' }

              it 'should return BooleanLiteral with true' do
                expression = BooleanLiteral.new(token: Token.new(type: Token::TRUE, literal: 'true'), value: true)
                expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

                expect(first_result).to eq expected
                expect(parser.error_message).to be_empty
              end
            end

            context 'when false' do
              let(:expressions) { 'false;' }

              it 'should return BooleanLiteral with true' do
                expression = BooleanLiteral.new(token: Token.new(type: Token::FALSE, literal: 'false'), value: false)
                expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

                expect(first_result).to eq expected
                expect(parser.error_message).to be_empty
              end
            end
          end

          context 'expression is prefix with minus' do

            context 'integer' do
              let(:expressions) { '-432718;' }

              it 'should return PrefixExpression' do
                right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '432718'), value: 432718)
                expression = PrefixExpression.new(token: Token.new(type: Token::MINUS, literal: '-'), operator: '-', right: right)
                expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

                expect(first_result).to eq expected
                expect(parser.error_message).to be_empty
              end
            end

            context 'identifier' do
              let(:expressions) { '-someVar;' }

              it 'should return PrefixExpression' do
                right = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'someVar'), value: 'someVar')
                expression = PrefixExpression.new(token: Token.new(type: Token::MINUS, literal: '-'), operator: '-', right: right)
                expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

                expect(first_result).to eq expected
                expect(parser.error_message).to be_empty
              end
            end
          end

          context 'expression is prefix with ~' do

            context 'integer' do
              let(:expressions) { '~432718;' }

              it 'should return PrefixExpression' do
                right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '432718'), value: 432718)
                expression = PrefixExpression.new(token: Token.new(type: Token::NOT, literal: '~'), operator: '~', right: right)
                expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

                expect(first_result).to eq expected
                expect(parser.error_message).to be_empty
              end
            end

            context 'identifier' do
              let(:expressions) { '~someVar;' }

              it 'should return PrefixExpression' do
                right = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'someVar'), value: 'someVar')
                expression = PrefixExpression.new(token: Token.new(type: Token::NOT, literal: '~'), operator: '~', right: right)
                expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

                expect(first_result).to eq expected
                expect(parser.error_message).to be_empty
              end
            end
          end

          context 'expression is this constant' do
            let(:expressions) { 'this;' }

            it 'should return ThisLiteral' do
              expression = ThisLiteral.new
              expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

              expect(first_result).to eq expected
              expect(parser.error_message).to be_empty
            end
          end

          context 'expression is null constant' do
            let(:expressions) { 'null;' }

            it 'should return BooleanLiteral with true' do
              expression = NullLiteral.new
              expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

              expect(first_result).to eq expected
              expect(parser.error_message).to be_empty
            end
          end

          context 'expression is integer calculation' do

            context 'two digits' do
              let(:left) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1) }
              let(:right) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '2'), value: 2) }

              context 'two terms' do
                let(:expression) { InfixExpression.new(token: Token.new(type: op_type, literal: op), left: left, operator: op, right: right) }
                let(:expected) { LetStatement.new(token: token, identifier: identifier, expression: expression) }
                let(:expressions) { '1' + op + '2' + ';' }

                context 'plus' do
                  let(:op) { '+' }
                  let(:op_type) { Token::PLUS }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
                  end
                end

                context 'minus' do
                  let(:op) { '-' }
                  let(:op_type) { Token::MINUS }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
                  end
                end

                context 'multiple' do
                  let(:op) { '*' }
                  let(:op_type) { Token::ASTERISK }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
                  end
                end

                context 'slash' do
                  let(:op) { '/' }
                  let(:op_type) { Token::SLASH }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
                  end
                end
              end

              context 'three terms' do
                let(:middle) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '3'), value: 3) }
                let(:right_expression) { InfixExpression.new(token: Token.new(type: op_type, literal: op), left: middle, operator: op, right: right) }
                let(:expression) { InfixExpression.new(token: Token.new(type: op_type, literal: op), left: left, operator: op, right: right_expression) }
                let(:expected) { LetStatement.new(token: token, identifier: identifier, expression: expression) }
                let(:expressions) { '1' + op + '3' + op + '2' + ';' }

                context 'plus' do
                  let(:op) { '+' }
                  let(:op_type) { Token::PLUS }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
                  end
                end

                context 'minus' do
                  let(:op) { '-' }
                  let(:op_type) { Token::MINUS }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
                  end
                end

                context 'multiple' do
                  let(:op) { '*' }
                  let(:op_type) { Token::ASTERISK }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
                  end
                end

                context 'slash' do
                  let(:op) { '/' }
                  let(:op_type) { Token::SLASH }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
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
                  let(:op) { '+' }
                  let(:op_type) { Token::PLUS }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
                  end
                end

                context 'minus' do
                  let(:op) { '-' }
                  let(:op_type) { Token::MINUS }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
                  end
                end

                context 'multiple' do
                  let(:op) { '*' }
                  let(:op_type) { Token::ASTERISK }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
                  end
                end

                context 'slash' do
                  let(:op) { '/' }
                  let(:op_type) { Token::SLASH }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
                  end
                end
              end

              context 'three terms' do
                let(:middle) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '333'), value: 333) }
                let(:right_expression) { InfixExpression.new(token: Token.new(type: op_type, literal: op), left: middle, operator: op, right: right) }
                let(:expression) { InfixExpression.new(token: Token.new(type: op_type, literal: op), left: left, operator: op, right: right_expression) }
                let(:expected) { LetStatement.new(token: token, identifier: identifier, expression: expression) }
                let(:expressions) { '111' + op + '333' + op + '222' + ';' }

                context 'plus' do
                  let(:op) { '+' }
                  let(:op_type) { Token::PLUS }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
                  end
                end

                context 'minus' do
                  let(:op) { '-' }
                  let(:op_type) { Token::MINUS }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
                  end
                end

                context 'multiple' do
                  let(:op) { '*' }
                  let(:op_type) { Token::ASTERISK }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
                  end
                end

                context 'slash' do
                  let(:op) { '/' }
                  let(:op_type) { Token::SLASH }

                  it do
                    expect(first_result).to eq expected
                    expect(parser.error_message).to be_empty
                  end
                end
              end
            end
          end

          context 'multiple prefix expression' do
            context 'minus' do
              let(:expressions) { '-1234 + 1273;' }

              it do
                infix_left = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1234'), value: 1234)
                infix_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1273'), value: 1273)
                right = InfixExpression.new(token: Token.new(type: Token::PLUS, literal: Token::PLUS), left: infix_left, operator: Token::PLUS, right: infix_right)
                expression = PrefixExpression.new(token: Token.new(type: Token::MINUS, literal: '-'), operator: '-', right: right)

                expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

                expect(first_result.token).to eq expected.token
                expect(first_result.identifier).to eq expected.identifier
                expect(first_result.expression.token).to eq expected.expression.token
                expect(first_result.expression.operator).to eq expected.expression.operator
                expect(first_result.expression.right).to eq expected.expression.right
                expect(parser.error_message).to be_empty
              end
            end

            context 'not' do
              let(:expressions) { '~indent + 1273;' }

              it do
                infix_left = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'indent'), value: 'indent')
                infix_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1273'), value: 1273)
                right = InfixExpression.new(token: Token.new(type: Token::PLUS, literal: Token::PLUS), left: infix_left, operator: Token::PLUS, right: infix_right)
                expression = PrefixExpression.new(token: Token.new(type: Token::NOT, literal: '~'), operator: '~', right: right)

                expected = LetStatement.new(token: token, identifier: identifier, expression: expression)

                expect(first_result.token).to eq expected.token
                expect(first_result.identifier).to eq expected.identifier
                expect(first_result.expression.token).to eq expected.expression.token
                expect(first_result.expression.operator).to eq expected.expression.operator
                expect(first_result.expression.right).to eq expected.expression.right
                expect(parser.error_message).to be_empty
              end
            end
          end
        end

        context 'with index' do
          let(:input) { "let variable[#{index}] =  111; }" }
          let(:expected) { LetStatement.new(token: token, identifier: identifier, expression: expression) }
          let(:identifier) { Identifier.new(token: Token.new(type: Token::IDENT, literal: 'variable'), value: 'variable', index: index_expression) }
          let(:expression) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '111'), value: 111) }

          context 'index is simple integer' do
            let(:index) { '1' }
            let(:index_expression) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1) }

            it do
              expect(first_result.token).to eq expected.token
              expect(first_result.identifier.token).to eq expected.identifier.token
              expect(first_result.identifier.value).to eq expected.identifier.value
              expect(first_result.identifier.index).to eq expected.identifier.index
              expect(first_result.expression).to eq expected.expression
              expect(parser.error_message).to be_empty
            end
          end

          context 'index is simple identifier' do
            let(:index) { 'idx' }
            let(:index_expression) { Identifier.new(token: Token.new(type: Token::IDENT, literal: 'idx'), value: 'idx') }

            it do
              expect(first_result.token).to eq expected.token
              expect(first_result.identifier.token).to eq expected.identifier.token
              expect(first_result.identifier.value).to eq expected.identifier.value
              expect(first_result.identifier.index).to eq expected.identifier.index
              expect(first_result.expression).to eq expected.expression
              expect(parser.error_message).to be_empty
            end
          end

          context 'index is integer calculation' do
            let(:index) { '1 + 2' }
            let(:index_expression) { InfixExpression.new(token: Token.new(type: Token::PLUS, literal: Token::PLUS), left: left, operator: Token::PLUS, right: right) }
            let(:left) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1) }
            let(:right) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '2'), value: 2) }

            it do
              expect(first_result.token).to eq expected.token
              expect(first_result.identifier.token).to eq expected.identifier.token
              expect(first_result.identifier.value).to eq expected.identifier.value
              expect(first_result.identifier.index).to eq expected.identifier.index
              expect(first_result.expression).to eq expected.expression
              expect(parser.error_message).to be_empty
            end
          end

          context 'index is identifier calculation' do
            let(:index) { 'idx1 + idx2' }
            let(:index_expression) { InfixExpression.new(token: Token.new(type: Token::PLUS, literal: Token::PLUS), left: left, operator: Token::PLUS, right: right) }
            let(:left) { Identifier.new(token: Token.new(type: Token::IDENT, literal: 'idx1'), value: 'idx1') }
            let(:right) { Identifier.new(token: Token.new(type: Token::IDENT, literal: 'idx2'), value: 'idx2') }

            it do
              expect(first_result.token).to eq expected.token
              expect(first_result.identifier.token).to eq expected.identifier.token
              expect(first_result.identifier.value).to eq expected.identifier.value
              expect(first_result.identifier.index).to eq expected.identifier.index
              expect(first_result.expression).to eq expected.expression
              expect(parser.error_message).to be_empty
            end
          end
        end

        context 'group expression' do
          let(:input) { "let variable = #{terms} }" }
          let(:expected) { LetStatement.new(token: token, identifier: identifier, expression: expression) }
          let(:identifier) { Identifier.new(token: Token.new(type: Token::IDENT, literal: 'variable'), value: 'variable') }

          context 'single term' do
            let(:expression) { BooleanLiteral.new(token: Token.new(type: Token::FALSE, literal: 'false'), value: false) }

            context 'single paren' do
              let(:terms) { '(false);' }

              it do
                expect(first_result.token).to eq expected.token
                expect(first_result.identifier).to eq expected.identifier
                expect(first_result.expression.token).to eq expected.expression.token
                expect(first_result.expression.value).to eq expected.expression.value
                expect(parser.error_message).to be_empty
              end
            end

            context 'two parens' do
              let(:terms) { '((false));' }

              it do
                expect(first_result.token).to eq expected.token
                expect(first_result.identifier).to eq expected.identifier
                expect(first_result.expression.token).to eq expected.expression.token
                expect(first_result.expression.value).to eq expected.expression.value
                expect(parser.error_message).to be_empty
              end
            end

            context 'three parens' do
              let(:terms) { '(((false)));' }

              it do
                expect(first_result.token).to eq expected.token
                expect(first_result.identifier).to eq expected.identifier
                expect(first_result.expression.token).to eq expected.expression.token
                expect(first_result.expression.value).to eq expected.expression.value
                expect(parser.error_message).to be_empty
              end
            end
          end

          context 'two terms' do
            let(:left) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '111'), value: 111) }
            let(:right) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '222'), value: 222) }
            let(:expression) { InfixExpression.new(token: Token.new(type: '+', literal: '+'), left: left, operator: '+', right: right) }

            context 'one paren' do
              context 'first' do
                let(:terms) { '(111) + 222;' }

                it do
                  expect(first_result.token).to eq expected.token
                  expect(first_result.identifier).to eq expected.identifier
                  expect(first_result.expression.token).to eq expected.expression.token
                  expect(first_result.expression.left).to eq expected.expression.left
                  expect(first_result.expression.operator).to eq expected.expression.operator
                  expect(first_result.expression.right).to eq expected.expression.right
                  expect(parser.error_message).to be_empty
                end
              end

              context 'last' do
                let(:terms) { '111 + (222);' }

                it do
                  expect(first_result.token).to eq expected.token
                  expect(first_result.identifier).to eq expected.identifier
                  expect(first_result.expression.token).to eq expected.expression.token
                  expect(first_result.expression.left).to eq expected.expression.left
                  expect(first_result.expression.operator).to eq expected.expression.operator
                  expect(first_result.expression.right).to eq expected.expression.right
                  expect(parser.error_message).to be_empty
                end
              end
            end

            context 'two parens' do
              context 'first' do
                let(:terms) { '((111) + 222);' }

                it do
                  expect(first_result.token).to eq expected.token
                  expect(first_result.identifier).to eq expected.identifier
                  expect(first_result.expression.token).to eq expected.expression.token
                  expect(first_result.expression.left).to eq expected.expression.left
                  expect(first_result.expression.operator).to eq expected.expression.operator
                  expect(first_result.expression.right).to eq expected.expression.right
                  expect(parser.error_message).to be_empty
                end
              end

              context 'double' do
                let(:terms) { '(111) + (222);' }

                it do
                  expect(first_result.token).to eq expected.token
                  expect(first_result.identifier).to eq expected.identifier
                  expect(first_result.expression.token).to eq expected.expression.token
                  expect(first_result.expression.left).to eq expected.expression.left
                  expect(first_result.expression.operator).to eq expected.expression.operator
                  expect(first_result.expression.right).to eq expected.expression.right
                  expect(parser.error_message).to be_empty
                end
              end

              context 'last' do
                let(:terms) { '(111 + (222));' }

                it do
                  expect(first_result.token).to eq expected.token
                  expect(first_result.identifier).to eq expected.identifier
                  expect(first_result.expression.token).to eq expected.expression.token
                  expect(first_result.expression.left).to eq expected.expression.left
                  expect(first_result.expression.operator).to eq expected.expression.operator
                  expect(first_result.expression.right).to eq expected.expression.right
                  expect(parser.error_message).to be_empty
                end
              end
            end
          end

          context 'three terms' do
            let(:left) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '111'), value: 111) }
            let(:middle) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '222'), value: 222) }
            let(:right) { IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '444'), value: 444) }

            context 'prioritize first' do
              let(:terms) { '(111 + 222) > 444;' }
              let(:left_expression) { InfixExpression.new(token: Token.new(type: '+', literal: '+'), left: left, operator: '+', right: middle) }
              let(:expression) { InfixExpression.new(token: Token.new(type: '>', literal: '>'), left: left_expression, operator: '>', right: right) }

              it do
                expect(first_result.token).to eq expected.token
                expect(first_result.identifier).to eq expected.identifier
                expect(first_result.expression.token).to eq expected.expression.token

                expect(first_result.expression.left.token).to eq expected.expression.left.token
                expect(first_result.expression.left.left).to eq expected.expression.left.left
                expect(first_result.expression.left.operator).to eq expected.expression.left.operator
                expect(first_result.expression.left.right).to eq expected.expression.left.right

                expect(first_result.expression.operator).to eq expected.expression.operator
                expect(first_result.expression.right).to eq expected.expression.right

                expect(parser.error_message).to be_empty
              end
            end

            context 'prioritize last' do
              let(:terms) { '111 > (222 + 444);' }
              let(:expression) { InfixExpression.new(token: Token.new(type: '>', literal: '>'), left: left, operator: '>', right: right_expression) }
              let(:right_expression) { InfixExpression.new(token: Token.new(type: '+', literal: '+'), left: middle, operator: '+', right: right) }

              it do
                expect(first_result.token).to eq expected.token
                expect(first_result.identifier).to eq expected.identifier
                expect(first_result.expression.token).to eq expected.expression.token

                expect(first_result.expression.left).to eq expected.expression.left
                expect(first_result.expression.operator).to eq expected.expression.operator

                expect(first_result.expression.right.token).to eq expected.expression.right.token
                expect(first_result.expression.right.left).to eq expected.expression.right.left
                expect(first_result.expression.right.operator).to eq expected.expression.right.operator
                expect(first_result.expression.right.right).to eq expected.expression.right.right

                expect(parser.error_message).to be_empty
              end
            end
          end
        end
      end

      context 'return statement' do
        let(:input) { "return #{expressions} }" }
        let(:token) { Token.new(type: Token::RETURN, literal: 'return') }

        subject(:first_result) { results.first }

        context 'expression is string constant' do
          let(:expressions) { '"This is a string sentence!!!";' }

          it 'should return StringLiteral' do
            expression = StringLiteral.new(token: Token.new(type: Token::STRING, literal: 'This is a string sentence!!!'), value: 'This is a string sentence!!!')
            expected = ReturnStatement.new(token: token, return_value: expression)

            expect(first_result).to eq expected
            expect(parser.error_message).to be_empty
          end
        end

        context 'expression is integer constant' do
          let(:expressions) { '432718;' }

          it 'should return IntegerLiteral' do
            expression = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '432718'), value: 432718)
            expected = ReturnStatement.new(token: token, return_value: expression)

            expect(first_result).to eq expected
            expect(parser.error_message).to be_empty
          end
        end

        context 'expression is boolean constant' do
          context 'when true' do
            let(:expressions) { 'true;' }

            it 'should return BooleanLiteral with true' do
              expression = BooleanLiteral.new(token: Token.new(type: Token::TRUE, literal: 'true'), value: true)
              expected = ReturnStatement.new(token: token, return_value: expression)

              expect(first_result).to eq expected
              expect(parser.error_message).to be_empty
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
            expect(parser.error_message).to be_empty
          end
        end

        context 'no expressions' do
          let(:expressions) { ';' }

          it 'return_value should be nil' do
            expected = ReturnStatement.new(token: token, return_value: nil)

            expect(first_result).to eq expected
            expect(parser.error_message).to be_empty
          end
        end
      end

      context 'if statement' do
        context 'without else' do
          let(:input) do
            '' '
        if(a < 2) {
let test1 = 1 + 2;

return test1;
}
}
        ' ''

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
            expect(parser.error_message).to be_empty
          end
        end

        context 'with else' do
          let(:input) do
            '' '
        if(a < 2) {
let test1 = 1 + 2;

return test1;
} else {
let test3 = 3 + 4;

return test3;

}
}
        ' ''
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
            expect(parser.error_message).to be_empty
          end
        end
      end

      context 'while statement' do
        context 'single line' do
          let(:input) do
            '' '
        while(i < 2) {
return test1;
}
}
        ' ''
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
            expect(parser.error_message).to be_empty
          end
        end

        context 'multiple line' do
          let(:input) do
            '' '
        while(i = 2) {
let test1 = 1 + 345;
let test2 = test1 * 1123;
return test2;
}
}
        ' ''
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
            expect(parser.error_message).to be_empty
          end
        end
      end

      context 'parse do statements' do
        let(:do_token) { Token.new(type: Token::DO, literal: 'do') }
        let(:ident) { Token.new(type: Token::IDENT, literal: 'some_thing') }
        subject(:first_result) { results.first }

        context 'without prefix' do
          context 'simple identifiers' do
            context 'zero parameter' do
              let(:input) do
                '' '
            do some_thing(); }
          ' ''
              end

              let(:args) { [] }

              it do
                expect(first_result.token).to eq do_token
                expect(first_result.prefix).to be_nil
                expect(first_result.function).to eq ident
                expect(first_result.arguments).to eq args
                expect(parser.error_message).to be_empty
              end
            end

            context 'one parameter' do
              let(:input) do
                '' '
          do some_thing(first); }
          ' ''
              end

              let(:args) { [Identifier.new(token: Token.new(type: Token::IDENT, literal: 'first'), value: 'first')] }

              it do
                expect(first_result.token).to eq do_token
                expect(first_result.prefix).to be_nil
                expect(first_result.function).to eq ident
                expect(first_result.arguments).to eq args
                expect(parser.error_message).to be_empty
              end
            end

            context 'three parameters' do
              let(:input) do
                '' '
          do some_thing(first, second, third); }
          ' ''
              end

              let(:args) do
                first = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'first'), value: 'first')
                second = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'second'), value: 'second')
                third = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'third'), value: 'third')

                [first, second, third]
              end

              it do
                expect(first_result.token).to eq do_token
                expect(first_result.prefix).to be_nil
                expect(first_result.function).to eq ident
                expect(first_result.arguments).to eq args
                expect(parser.error_message).to be_empty
              end
            end
          end

          context 'integer calculation' do
            context 'one parameter' do
              let(:input) do
                '' '
          do some_thing(1 + 22); }
          ' ''
              end

              let(:args) do
                left = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1)
                right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '22'), value: 22)
                exp = InfixExpression.new(token: Token.new(type: Token::PLUS, literal: '+'), left: left, operator: '+', right: right)

                [exp]
              end

              it do
                expect(first_result.token).to eq do_token
                expect(first_result.prefix).to be_nil
                expect(first_result.function).to eq ident
                expect(first_result.arguments).to eq args
                expect(parser.error_message).to be_empty
              end
            end

            context 'three parameters' do
              let(:input) do
                '' '
          do some_thing(1 + 2, second / 22, third * 555); }
          ' ''
              end

              let(:args) do
                first_left = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1)
                first_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '2'), value: 2)
                first_exp = InfixExpression.new(token: Token.new(type: Token::PLUS, literal: '+'), left: first_left, operator: '+', right: first_right)

                second_left = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'second'), value: 'second')
                second_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '22'), value: 22)
                second_exp = InfixExpression.new(token: Token.new(type: Token::SLASH, literal: '/'), left: second_left, operator: '/', right: second_right)

                third_left = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'third'), value: 'third')
                third_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '555'), value: 555)
                third_exp = InfixExpression.new(token: Token.new(type: Token::ASTERISK, literal: '*'), left: third_left, operator: '*', right: third_right)

                [first_exp, second_exp, third_exp]
              end

              it do
                expect(first_result.token).to eq do_token
                expect(first_result.prefix).to be_nil
                expect(first_result.function).to eq ident
                expect(first_result.arguments[0]).to eq args[0]
                expect(first_result.arguments[1]).to eq args[1]
                expect(first_result.arguments[2]).to eq args[2]
                expect(parser.error_message).to be_empty
              end
            end
          end
        end

        context 'with prefix' do
          context 'prefix is this' do
            let(:prefix) { Token.new(type: Token::THIS, literal: 'this') }

            context 'simple identifiers' do
              context 'zero parameter' do
                let(:input) do
                  '' '
            do this.some_thing(); }
          ' ''
                end

                let(:args) { [] }

                it do
                  expect(first_result.token).to eq do_token
                  expect(first_result.prefix).to eq prefix
                  expect(first_result.function).to eq ident
                  expect(first_result.arguments).to eq args
                  expect(parser.error_message).to be_empty
                end
              end

              context 'one parameter' do
                let(:input) do
                  '' '
          do this.some_thing(first); }
          ' ''
                end

                let(:args) { [Identifier.new(token: Token.new(type: Token::IDENT, literal: 'first'), value: 'first')] }

                it do
                  expect(first_result.token).to eq do_token
                  expect(first_result.prefix).to eq prefix
                  expect(first_result.function).to eq ident
                  expect(first_result.arguments).to eq args
                  expect(parser.error_message).to be_empty
                end
              end

              context 'three parameters' do
                let(:input) do
                  '' '
          do this.some_thing(first, second, third); }
          ' ''
                end

                let(:args) do
                  first = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'first'), value: 'first')
                  second = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'second'), value: 'second')
                  third = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'third'), value: 'third')

                  [first, second, third]
                end

                it do
                  expect(first_result.token).to eq do_token
                  expect(first_result.prefix).to eq prefix
                  expect(first_result.function).to eq ident
                  expect(first_result.arguments).to eq args
                  expect(parser.error_message).to be_empty
                end
              end
            end

            context 'integer calculation' do
              context 'one parameter' do
                let(:input) do
                  '' '
          do this.some_thing(1 + 22); }
          ' ''
                end

                let(:args) do
                  left = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1)
                  right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '22'), value: 22)
                  exp = InfixExpression.new(token: Token.new(type: Token::PLUS, literal: '+'), left: left, operator: '+', right: right)

                  [exp]
                end

                it do
                  expect(first_result.token).to eq do_token
                  expect(first_result.function).to eq ident
                  expect(first_result.prefix).to eq prefix
                  expect(first_result.arguments).to eq args
                  expect(parser.error_message).to be_empty
                end
              end

              context 'three parameters' do
                let(:input) do
                  '' '
          do this.some_thing(1 + 2, second / 22, third * 555); }
          ' ''
                end

                let(:args) do
                  first_left = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1)
                  first_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '2'), value: 2)
                  first_exp = InfixExpression.new(token: Token.new(type: Token::PLUS, literal: '+'), left: first_left, operator: '+', right: first_right)

                  second_left = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'second'), value: 'second')
                  second_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '22'), value: 22)
                  second_exp = InfixExpression.new(token: Token.new(type: Token::SLASH, literal: '/'), left: second_left, operator: '/', right: second_right)

                  third_left = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'third'), value: 'third')
                  third_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '555'), value: 555)
                  third_exp = InfixExpression.new(token: Token.new(type: Token::ASTERISK, literal: '*'), left: third_left, operator: '*', right: third_right)

                  [first_exp, second_exp, third_exp]
                end

                it do
                  expect(first_result.token).to eq do_token
                  expect(first_result.prefix).to eq prefix
                  expect(first_result.function).to eq ident
                  expect(first_result.arguments[0]).to eq args[0]
                  expect(first_result.arguments[1]).to eq args[1]
                  expect(first_result.arguments[2]).to eq args[2]
                  expect(parser.error_message).to be_empty
                end
              end
            end
          end

          context 'prefix is identifier' do
            let(:prefix) { Token.new(type: Token::IDENT, literal: 'someClass') }

            context 'simple identifiers' do
              context 'zero parameter' do
                let(:input) do
                  '' '
            do someClass.some_thing(); }
          ' ''
                end

                let(:args) { [] }

                it do
                  expect(first_result.token).to eq do_token
                  expect(first_result.prefix).to eq prefix
                  expect(first_result.function).to eq ident
                  expect(first_result.arguments).to eq args
                  expect(parser.error_message).to be_empty
                end
              end

              context 'one parameter' do
                let(:input) do
                  '' '
          do someClass.some_thing(first); }
          ' ''
                end

                let(:args) { [Identifier.new(token: Token.new(type: Token::IDENT, literal: 'first'), value: 'first')] }

                it do
                  expect(first_result.token).to eq do_token
                  expect(first_result.prefix).to eq prefix
                  expect(first_result.function).to eq ident
                  expect(first_result.arguments).to eq args
                  expect(parser.error_message).to be_empty
                end
              end

              context 'three parameters' do
                let(:input) do
                  '' '
          do someClass.some_thing(first, second, third); }
          ' ''
                end

                let(:args) do
                  first = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'first'), value: 'first')
                  second = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'second'), value: 'second')
                  third = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'third'), value: 'third')

                  [first, second, third]
                end

                it do
                  expect(first_result.token).to eq do_token
                  expect(first_result.prefix).to eq prefix
                  expect(first_result.function).to eq ident
                  expect(first_result.arguments).to eq args
                  expect(parser.error_message).to be_empty
                end
              end
            end

            context 'integer calculation' do
              context 'one parameter' do
                let(:input) do
                  '' '
          do someClass.some_thing(1 + 22); }
          ' ''
                end

                let(:args) do
                  left = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1)
                  right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '22'), value: 22)
                  exp = InfixExpression.new(token: Token.new(type: Token::PLUS, literal: '+'), left: left, operator: '+', right: right)

                  [exp]
                end

                it do
                  expect(first_result.token).to eq do_token
                  expect(first_result.function).to eq ident
                  expect(first_result.prefix).to eq prefix
                  expect(first_result.arguments).to eq args
                  expect(parser.error_message).to be_empty
                end
              end

              context 'three parameters' do
                let(:input) do
                  '' '
          do someClass.some_thing(1 + 2, second / 22, third * 555); }
          ' ''
                end

                let(:args) do
                  first_left = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1)
                  first_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '2'), value: 2)
                  first_exp = InfixExpression.new(token: Token.new(type: Token::PLUS, literal: '+'), left: first_left, operator: '+', right: first_right)

                  second_left = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'second'), value: 'second')
                  second_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '22'), value: 22)
                  second_exp = InfixExpression.new(token: Token.new(type: Token::SLASH, literal: '/'), left: second_left, operator: '/', right: second_right)

                  third_left = Identifier.new(token: Token.new(type: Token::IDENT, literal: 'third'), value: 'third')
                  third_right = IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '555'), value: 555)
                  third_exp = InfixExpression.new(token: Token.new(type: Token::ASTERISK, literal: '*'), left: third_left, operator: '*', right: third_right)

                  [first_exp, second_exp, third_exp]
                end

                it do
                  expect(first_result.token).to eq do_token
                  expect(first_result.prefix).to eq prefix
                  expect(first_result.function).to eq ident
                  expect(first_result.arguments[0]).to eq args[0]
                  expect(first_result.arguments[1]).to eq args[1]
                  expect(first_result.arguments[2]).to eq args[2]
                  expect(parser.error_message).to be_empty
                end
              end
            end
          end
        end
      end
    end

    context 'abnormal' do
      context 'body' do
        subject do
          parser.parse_statements
          parser.error_message
        end

        context 'let statement' do
          context 'ident is missing' do
            let(:input) { 'let = 111; }' }

            it 'raise Parser::ParseError' do
              is_expected.to eq 'expected next token to be IDENT, got = instead.'
            end
          end

          context 'eq is missing' do
            let(:input) { 'let variable 111; }' }

            it 'raise Parser::ParseError' do
              is_expected.to eq 'expected next token to be =, got INT instead.'
            end
          end

          context 'expression is missing' do
            let(:input) { 'let variable =; }' }

            it 'raise Parser::ParseError' do
              is_expected.not_to be_empty
            end
          end

          context 'semicolon is missing' do
            let(:input) { 'let variable = 111 }' }

            it 'raise Parser::ParseError' do
              is_expected.not_to be_empty
            end
          end
        end

        context 'return statement' do
          context 'semicolon is missing' do
            let(:input) { 'return 111 }'  }

            it 'raise Parser::ParseError' do
              is_expected.to eq 'expected next token to be ;, got EOF instead.'
            end
          end
        end

        context 'if statement' do
          context 'condition' do
            context 'left paren is missing' do
              let(:input) { 'if a < 1){ return true; } }' }

              it 'raise Parser::ParseError' do
                is_expected.to eq 'expected next token to be (, got IDENT instead.'
              end
            end

            context 'expression is missing' do
              let(:input) { 'if (){ return true; } }' }

              it 'raise Parser::ParseError' do
                is_expected.to eq "no prefix parse function for ) found.\nexpected next token to be ), got { instead."
              end
            end

            context 'rparen is missing' do
              let(:input) { 'if (a < 1{ return true; } }' }

              it 'raise Parser::ParseError' do
                is_expected.not_to be_empty
              end
            end
          end

          context 'consequence' do
            context 'left rbrace is missing' do
              let(:input) { 'if (a < 1) return true; } }' }

              it 'raise Parser::ParseError' do
                is_expected.to eq 'expected next token to be {, got RETURN instead.'
              end
            end

            context 'left body is missing' do
              let(:input) { 'if (a < 1) {} }' }

              it 'should not raise Error' do # I know it should not be here, but...
                is_expected.to be_empty
              end
            end
          end

          context 'else' do
            context 'lbrace is missing' do
              let(:input) { 'if (a < 1) { return true; } else return false;} }' }

              it 'raise Parser::ParseError' do
                is_expected.to eq 'expected next token to be {, got RETURN instead.'
              end
            end

            context 'rbrace is missing' do
              let(:input) { 'if (a < 1) { return true; } else { return false; }' }

              it 'raise Parser::ParseError' do
                is_expected.to eq 'unexpected EOF has gotten.'
              end
            end
          end
        end

        context 'while statement' do
          context 'condition' do
            context 'condition is missing' do
              let(:input) { 'while (){return false;} }' }

              it 'raise Parser::ParseError' do
                is_expected.not_to be_empty
              end
            end

            context 'lparen is missing' do
              let(:input) { 'while false){return false;} }' }

              it 'raise Parser::ParseError' do
                is_expected.to eq 'expected next token to be (, got FALSE instead.'
              end
            end

            context 'rparen is missing' do
              let(:input) { 'while (false{return false;} }' }

              it 'raise Parser::ParseError' do
                is_expected.to eq 'expected next token to be ), got RETURN instead.'
              end
            end
          end

          context 'body' do
            context 'lbrace is missing' do
              let(:input) { 'while (true) return false;} }' }

              it 'raise Parser::ParseError' do
                is_expected.to eq 'expected next token to be {, got RETURN instead.'
              end
            end

            context 'semicolon is missing' do
              let(:input) { 'while (true) {return false} }' }

              it 'raise Parser::ParseError' do
                is_expected.to eq "expected next token to be ;, got } instead.\nunexpected EOF has gotten."
              end
            end

            context 'rbrace is missing' do
              let(:input) { 'while (true) {return false;}' }

              it 'raise Parser::ParseError' do
                is_expected.to eq 'unexpected EOF has gotten.'
              end
            end
          end
        end

        context 'do statement' do
          context 'only period' do
            let(:input) { 'do .some_method(); }' }

            it 'raise Parser::ParseError' do
              is_expected.to eq 'expected next token to be IDENT or THIS, got . instead.'
            end
          end

          context 'missing lparen' do
            let(:input) { 'do some_method); }' }

            it 'raise Parser::ParseError' do
              is_expected.to eq 'expected next token to be (, got ) instead.'
            end
          end

          context 'missing rparen' do
            let(:input) { 'do some_method(; }' }

            it 'raise Parser::ParseError' do
              is_expected.to eq "no prefix parse function for ; found.\nexpected next token to be ), got } instead.\nexpected next token to be ;, got } instead."
            end
          end

          context 'missing semicolon' do
            let(:input) { 'do some_method() }' }

            it 'raise Parser::ParseError' do
              is_expected.to eq 'expected next token to be ;, got } instead.'
            end
          end

          context 'only comma' do
            let(:input) { 'do some_method(,); }' }

            it 'raise Parser::ParseError' do
              is_expected.to eq 'no prefix parse function for , found.'
            end
          end

          context 'last comma' do
            let(:input) { 'do some_method(some, thing, ); }' }

            it 'raise Parser::ParseError' do
              is_expected.to eq "no prefix parse function for ) found.\nexpected next token to be ), got ; instead."
            end
          end
        end

        context 'group expression' do
          context 'unmatching left parens' do
            let(:input) { 'let some = ((1 + 2); }' }

            it 'raise Parser::ParseError' do
              is_expected.to eq 'expected next token to be ), got ; instead.'
            end
          end

          context 'unmatching right parens' do
            let(:input) { 'let some = (1 + 2)); }' }

            it 'raise Parser::ParseError' do
              is_expected.to eq 'expected next token to be ;, got ) instead.'
            end
          end
        end
      end

      context 'parse_var_declarations' do
        subject do
          parser.parse_var_declarations
          parser.error_message
        end

        context 'class name is missing' do
          let(:input) { 'var someVar;' }

          it do
            is_expected.to eq 'expected next token to be IDENT, got ; instead.'
          end
        end

        context 'var name is missing' do
          let(:input) { 'var int;' }

          it 'raise Parser::ParseError' do
            is_expected.to eq 'expected next token to be IDENT, got ; instead.'
          end
        end

        context 'semicolon is missing' do
          let(:input) { 'var int someVar' }

          it 'raise Parser::ParseError' do
            is_expected.to eq 'expected next token to be ;, got EOF instead.'
          end
        end

        context 'comma is missing' do
          let(:input) { 'var int i1 i2;' }

          it 'raise Parser::ParseError' do
            is_expected.to eq 'expected next token to be ;, got IDENT instead.'
          end
        end

        context 'semicolon is missing' do
          let(:input) { 'var int i1, i2, i3' }

          it 'raise Parser::ParseError' do
            is_expected.to eq 'expected next token to be ;, got EOF instead.'
          end
        end
      end

      context 'parse_parameters' do
        subject do
          parser.parse_parameters
          parser.error_message
        end

        context 'left paren is missing' do
          let(:input) { 'int i)' }

          it do
            is_expected.to eq 'expected next token to be IDENT, got ) instead.'
          end
        end

        context 'class type is missing' do
          let(:input) { '(i)' }

          it do
            is_expected.to eq 'expected next token to be IDENT, got ) instead.'
          end
        end

        context 'ident is missing' do
          let(:input) { '(int )' }

          it do
            is_expected.to eq 'expected next token to be IDENT, got ) instead.'
          end
        end

        context 'right paren is missing' do
          let(:input) { '(int i' }

          it do
            is_expected.to eq 'expected next token to be ), got EOF instead.'
          end
        end
      end

      context 'parse_class' do
        subject do
          parser.parse_class
          parser.error_message
        end

        context 'rbrace is missing' do
          let(:input) do
            '''
        class SomeClass
constructor Square new(int Ax, int Ay, int Asize) {
      let x = Ax;
      let y = Ay;
      let size = Asize;
      do draw();
      return this;
   }
}
        '''
          end

          it {is_expected.to eq 'expected next token to be {, got CONSTRUCTOR instead.'}
        end

        context 'lbrace is missing' do
          let(:input) do
            '''
        class SomeClass {
constructor Square new(int Ax, int Ay, int Asize) {
      let x = Ax;
      let y = Ay;
      let size = Asize;
      do draw();
      return this;
   }

        '''
          end

          it {is_expected.to eq 'unexpected EOF has gotten.'}
        end
      end
    end
  end
end