require 'spec_helper'

describe DoStatement do
  let(:do_statement) { DoStatement.new(token: 'token', prefix: prefix, function: Identifier.new(token: Token.new(type: Token::IDENT, literal: 'some_function'), value: 'some_function'), arguments: arguments) }

  describe '#to_h / to_xml' do
    subject(:hash) { do_statement.to_h }
    subject(:xml) { do_statement.to_xml }

    context 'prefix is this' do
      let(:prefix) { ThisLiteral.new }

      context 'arguments are blank' do
        let(:arguments) { [] }

        it do
          expected = {
            doStatement: [
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
            doStatement: [
              { keyword: 'do' },
              { keyword: 'this' },
              { symbol: '.' },
              { identifier: 'some_function' },
              { symbol: '(' },
              { expressionList: [ { expression: { term: { integerConstant: 432718 } } } ] },
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

      context 'arguments are multiple integers' do
        let(:arguments) { [IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '432718'), value: 432718), IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '324'), value: 324)] }

        it do
          expected = {
            doStatement: [
              { keyword: 'do' },
              { keyword: 'this' },
              { symbol: '.' },
              { identifier: 'some_function' },
              { symbol: '(' },
              { expressionList: [ { expression: { term: { integerConstant: 432718 } } }, { expression: { term: { integerConstant: 324 } } } ] },
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
      let(:prefix) { Identifier.new(token: Token.new(type: Token::IDENT, literal: 'first'), value: 'first') }

      context 'arguments are blank' do
        context 'arguments are blank' do
          let(:arguments) { [] }

          it do
            expected = {
              doStatement: [
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