require 'spec_helper'

describe IfStatement do
  let(:if_statement) { IfStatement.new(token: 'token', condition: condition, consequence: consequence, alternative: alternative) }

  describe '#to_h / to_xml' do
    subject(:hash) { if_statement.to_h }
    subject(:xml) { if_statement.to_xml }

    let(:condition) { InfixExpression.new(token: Token.new(type: '<', literal: '<'), left: condition_left, operator: '<', right: condition_right) }
    let(:condition_left){ Identifier.new(token: Token.new(type: Token::IDENT, literal: 'a'), value: 'a') }
    let(:condition_right){ IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '2'), value: 2) }

    context 'without consequence' do
      let(:consequence) { BlockStatement.new(token: 'token', statements: []) }
      let(:alternative) { nil }

      it do
        expected = {
          if_statement: [
            {keyword: 'if'},
            {symbol: '('},
            {symbol: '('},
            {expression: [{term: [{identifier: 'a'}]}, {symbol: '<'}, {term: {integer_constant: 2}}]},
            {symbol: ')'},
            {symbol: '{'},
            {statements: []},
            {symbol: '}'}
          ]
        }

        expect(hash).to eq expected
      end

      it do
        expected ='<ifStatement><keyword>if</keyword><symbol>(</symbol><symbol>(</symbol><expression><term><identifier>a</identifier></term><symbol>&lt;</symbol><term><integerConstant>2</integerConstant></term></expression><symbol>)</symbol><symbol>{</symbol><statements></statements><symbol>}</symbol></ifStatement>'
        expect(xml).to eq expected
      end
    end

    context 'with consequence' do
      # Let statement in the consequence
      let(:consequence_ident){Identifier.new(token: Token.new(type: Token::IDENT, literal: 'test1'), value: 'test1')}
      let(:consequence_left){IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '1'), value: 1)}
      let(:consequence_right){IntegerLiteral.new(token: Token.new(type: Token::INT, literal: '2'), value: 2)}
      let(:consequence_op){Token::PLUS}
      let(:consequence_expression){InfixExpression.new(token: Token.new(type: consequence_op, literal: consequence_op), left: consequence_left, operator: consequence_op, right: consequence_right)}
      let(:consequence_let){LetStatement.new(token: Token.new(type: Token::LET, literal: 'let'), identifier: consequence_ident, expression: consequence_expression)}

      # Return statement in the consequence
      let(:consequence_return){ReturnStatement.new(token: Token.new(type: Token::RETURN, literal: 'return'), return_value: consequence_ident)}
      let(:consequence){BlockStatement.new(token: Token.new(type: Token::LBRACE, literal: '{'), statements: [consequence_let, consequence_return])}

      context 'wuthout altenative' do
        let(:alternative) { nil }

        it do
          expected = {:if_statement=>
            [{:keyword=>"if"},
              {:symbol=>"("},
              {:symbol=>"("},
              {:expression=>[{:term=>[{:identifier=>"a"}]}, {:symbol=>"<"}, {:term=>{:integer_constant=>2}}]},
              {:symbol=>")"},
              {:symbol=>"{"},
              {:statements=>
                [{:let_statement=>
                  [{:keyword=>"let"},
                    {:identifier=>"test1"},
                    {:symbol=>"="},
                    {:expression=>[{:term=>{:integer_constant=>1}}, {:symbol=>"+"}, {:term=>{:integer_constant=>2}}]},
                    {:symbol=>";"}]},
                  {:return_statement=>{:keyword=>"return", :expression=>{:term=>[{:identifier=>"test1"}]}, :symbol=>";"}}]},
              {:symbol=>"}"}]}

          expect(hash).to eq expected
        end

        it do
          expected ='<ifStatement><keyword>if</keyword><symbol>(</symbol><symbol>(</symbol><expression><term><identifier>a</identifier></term><symbol>&lt;</symbol><term><integerConstant>2</integerConstant></term></expression><symbol>)</symbol><symbol>{</symbol><statements><letStatement><keyword>let</keyword><identifier>test1</identifier><symbol>=</symbol><expression><term><integerConstant>1</integerConstant></term><symbol>+</symbol><term><integerConstant>2</integerConstant></term></expression><symbol>;</symbol></letStatement><returnStatement><keyword>return</keyword><expression><term><identifier>test1</identifier></term></expression><symbol>;</symbol></returnStatement></statements><symbol>}</symbol></ifStatement>'
          expect(xml).to eq expected
        end
      end

      context 'wuthout altenative' do
        let(:alternative){ BlockStatement.new(token: Token.new(type: Token::LBRACE, literal: '{'), statements: [consequence_let, consequence_return]) }

        it do
          expected = {:if_statement=>
            [{:keyword=>"if"},
              {:symbol=>"("},
              {:symbol=>"("},
              {:expression=>[{:term=>[{:identifier=>"a"}]}, {:symbol=>"<"}, {:term=>{:integer_constant=>2}}]},
              {:symbol=>")"},
              {:symbol=>"{"},
              {:statements=>
                [{:let_statement=>
                  [{:keyword=>"let"},
                    {:identifier=>"test1"},
                    {:symbol=>"="},
                    {:expression=>[{:term=>{:integer_constant=>1}}, {:symbol=>"+"}, {:term=>{:integer_constant=>2}}]},
                    {:symbol=>";"}]},
                  {:return_statement=>{:keyword=>"return", :expression=>{:term=>[{:identifier=>"test1"}]}, :symbol=>";"}}]},
              {:symbol=>"}"},
              {:keyword=>"else"},
              {:symbol=>"{"},
              {:statements=>
                [{:let_statement=>
                  [{:keyword=>"let"},
                    {:identifier=>"test1"},
                    {:symbol=>"="},
                    {:expression=>[{:term=>{:integer_constant=>1}}, {:symbol=>"+"}, {:term=>{:integer_constant=>2}}]},
                    {:symbol=>";"}]},
                  {:return_statement=>{:keyword=>"return", :expression=>{:term=>[{:identifier=>"test1"}]}, :symbol=>";"}}]},
              {:symbol=>"}"}]}

          expect(hash).to eq expected
        end

        it do
          expected ='<ifStatement><keyword>if</keyword><symbol>(</symbol><symbol>(</symbol><expression><term><identifier>a</identifier></term><symbol>&lt;</symbol><term><integerConstant>2</integerConstant></term></expression><symbol>)</symbol><symbol>{</symbol><statements><letStatement><keyword>let</keyword><identifier>test1</identifier><symbol>=</symbol><expression><term><integerConstant>1</integerConstant></term><symbol>+</symbol><term><integerConstant>2</integerConstant></term></expression><symbol>;</symbol></letStatement><returnStatement><keyword>return</keyword><expression><term><identifier>test1</identifier></term></expression><symbol>;</symbol></returnStatement></statements><symbol>}</symbol><keyword>else</keyword><symbol>{</symbol><statements><letStatement><keyword>let</keyword><identifier>test1</identifier><symbol>=</symbol><expression><term><integerConstant>1</integerConstant></term><symbol>+</symbol><term><integerConstant>2</integerConstant></term></expression><symbol>;</symbol></letStatement><returnStatement><keyword>return</keyword><expression><term><identifier>test1</identifier></term></expression><symbol>;</symbol></returnStatement></statements><symbol>}</symbol></ifStatement>'
          expect(xml).to eq expected
        end
      end
    end
  end
end