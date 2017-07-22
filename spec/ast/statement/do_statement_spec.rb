require 'spec_helper'

describe DoStatement do
  let(:do_statement) { DoStatement.new(token: 'token', prefix: prefix, function: Token.new(type: Token::IDENT, literal: 'some_function'), arguments: arguments) }

  describe '#to_h / to_xml' do
    subject(:hash) { do_statement.to_h }
    subject(:xml) { do_statement.to_xml }

    context 'prefix is this' do
      let(:prefix) { Token.new(type: Token::THIS, literal: 'this') }

      context 'arguments are blank' do
        let(:arguments) { [] }

        it do
          expected = {
            do_statement: [
              { keyword: 'do' },
              { keyword: 'this' },
              { symbol: '.' },
              { identifier: 'some_function' },
              { symbol: '(' },
              { expressionList: '' },
              { symbol: ')' },
              { symbol: ';' },
            ]
          }

          expect(hash).to eq expected
        end

        it do
          expected = '<doStatement><keyword>do</keyword><keyword>this</keyword><symbol>.</symbol><identifier>some_function</identifier><symbol>(</symbol><expressionList></expressionList><symbol>)</symbol><symbol>;</symbol></doStatement>'

          expect(xml).to eq expected
        end
      end

      context 'argument is integer' do
        let(:arguments) { [IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '432718'), value: 432718)] }

        it do
          expected = {
            do_statement: [
              { keyword: 'do' },
              { keyword: 'this' },
              { symbol: '.' },
              { identifier: 'some_function' },
              { symbol: '(' },
              { expressionList: [ { expression: { term: { integer_constant: 432718 } } } ] },
              { symbol: ')' },
              { symbol: ';' },
            ]
          }

          expect(hash).to eq expected
        end

        it do
          expected = '<doStatement><keyword>do</keyword><keyword>this</keyword><symbol>.</symbol><identifier>some_function</identifier><symbol>(</symbol><expressionList><expression><term><integerConstant>432718</integerConstant></term></expression></expressionList><symbol>)</symbol><symbol>;</symbol></doStatement>'

          expect(xml).to eq expected
        end
      end

      context 'argument is infix expression' do
        let(:arguments) { [ infix ] }
        let(:left){ IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1234'), value: 1234) }
        let(:right){ IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1273'), value: 1273) }
        let(:infix){ InfixExpression.new(token: Token.new(type: Token::PLUS, literal: Token::PLUS), left: left, operator: Token::PLUS, right: right) }

        it do
          expected = {
            do_statement: [
              { keyword: 'do' },
              { keyword: 'this' },
              { symbol: '.' },
              { identifier: 'some_function' },
              { symbol: '(' },
              { expressionList: [ { expression: [ { term: { integer_constant: 1234 } }, { symbol: '+'}, { term: { integer_constant: 1273 } } ] } ] },
              { symbol: ')' },
              { symbol: ';' },
            ]
          }

          expect(hash).to eq expected
        end

        it do
          expected = '<doStatement><keyword>do</keyword><keyword>this</keyword><symbol>.</symbol><identifier>some_function</identifier><symbol>(</symbol><expressionList><expression><term><integerConstant>1234</integerConstant></term><symbol>+</symbol><term><integerConstant>1273</integerConstant></term></expression></expressionList><symbol>)</symbol><symbol>;</symbol></doStatement>'

          expect(xml).to eq expected
        end
      end

      context 'argument is prefix expression' do
        let(:arguments) { [ prefix_exp ] }
        let(:right){ Identifier.new(token: Token.new(type: Token::IDENT, literal: 'something'), value: 'something') }
        let(:prefix_exp){ PrefixExpression.new(token: Token.new(type: Token::MINUS, literal: '-'), operator: '-', right: right) }

        it do
          expected = {
            do_statement: [
              { keyword: 'do' },
              { keyword: 'this' },
              { symbol: '.' },
              { identifier: 'some_function' },
              { symbol: '(' },
              { expressionList: [ { expression: { term: [ {symbol: '-'}, { term: [ { identifier: 'something' } ] } ] } } ] },
              { symbol: ')' },
              { symbol: ';' },
            ]
          }

          expect(hash).to eq expected
        end

        it do
          expected = '<doStatement><keyword>do</keyword><keyword>this</keyword><symbol>.</symbol><identifier>some_function</identifier><symbol>(</symbol><expressionList><expression><term><symbol>-</symbol><term><identifier>something</identifier></term></term></expression></expressionList><symbol>)</symbol><symbol>;</symbol></doStatement>'

          expect(xml).to eq expected
        end
      end

      context 'arguments are multiple integers' do
        let(:arguments) { [IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '432718'), value: 432718), IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '324'), value: 324)] }

        it do
          expected = {
            do_statement: [
              { keyword: 'do' },
              { keyword: 'this' },
              { symbol: '.' },
              { identifier: 'some_function' },
              { symbol: '(' },
              { expressionList: [ { expression: { term: { integer_constant: 432718 } } }, { expression: { term: { integer_constant: 324 } } } ] },
              { symbol: ')' },
              { symbol: ';' },
            ]
          }

          expect(hash).to eq expected
        end

        it do
          expected = '<doStatement><keyword>do</keyword><keyword>this</keyword><symbol>.</symbol><identifier>some_function</identifier><symbol>(</symbol><expressionList><expression><term><integerConstant>432718</integerConstant></term></expression><expression><term><integerConstant>324</integerConstant></term></expression></expressionList><symbol>)</symbol><symbol>;</symbol></doStatement>'

          expect(xml).to eq expected
        end
      end
    end

    context 'prefix is ident' do
      let(:prefix) { Token.new(type: Token::IDENT, literal: 'first') }

      context 'arguments are blank' do
        context 'arguments are blank' do
          let(:arguments) { [] }

          it do
            expected = {
              do_statement: [
                { keyword: 'do' },
                { identifier: 'first' },
                { symbol: '.' },
                { identifier: 'some_function' },
                { symbol: '(' },
                { expressionList: '' },
                { symbol: ')' },
                { symbol: ';' },
              ]
            }

            expect(hash).to eq expected
          end

          it do
            expected = '<doStatement><keyword>do</keyword><identifier>first</identifier><symbol>.</symbol><identifier>some_function</identifier><symbol>(</symbol><expressionList></expressionList><symbol>)</symbol><symbol>;</symbol></doStatement>'

            expect(xml).to eq expected
          end
        end
      end
    end
  end
end