require 'spec_helper'
require 'pry-byebug'

describe Lexer do
  describe '# next_token' do
    context 'when symbols are given' do
      let(:symbols) { {
        '=': {type: Token::EQ, literal: '='},
        '~': {type: Token::NOT, literal: '~'},
        '+': {type: Token::PLUS, literal: '+'},
        '-': {type: Token::MINUS, literal: '-'},
        '*': {type: Token::ASTERISK, literal: '*'},
        '/': {type: Token::SLASH, literal: '/'},
        '<': {type: Token::LT, literal: '<'},
        '>': {type: Token::GT, literal: '>'},
        '&': {type: Token::AND, literal: '&'},
        '|': {type: Token::OR, literal: '|'},
        '.': {type: Token::PERIOD, literal: '.'},
        ',': {type: Token::COMMA, literal: ','},
        ';': {type: Token::SEMICOLON, literal: ';'},
        '(': {type: Token::LPAREN, literal: '('},
        ')': {type: Token::RPAREN, literal: ')'},
        '{': {type: Token::LBRACE, literal: '{'},
        '}': {type: Token::RBRACE, literal: '}'},
        '[': {type: Token::LBRACK, literal: '['},
        ']': {type: Token::RBRACK, literal: ']'},
        '': {type: Token::EOF, literal: ''},
      } }

      it 'should return a right token' do
        assert_tokens symbols
      end
    end

    context 'when strings are given' do
      let(:strings) { {
        '"this is a string"': {type: Token::STRING, literal: 'this is a string'},
        '"I am string!!!!!!"': {type: Token::STRING, literal: 'I am string!!!!!!'},
      } }

      it 'should return a right token' do
        assert_tokens strings
      end
    end

    context 'when keywords are given' do
      let(:keywords) { {
        'class': {type: Token::CLASS, literal: 'class'},
        'constructor': {type: Token::CONSTRUCTOR, literal: 'constructor'},
        'function': {type: Token::FUNCTION, literal: 'function'},
        'method': {type: Token::METHOD, literal: 'method'},
        'field': {type: Token::FIELD, literal: 'field'},
        'static': {type: Token::STATIC, literal: 'static'},
        'var': {type: Token::VAR, literal: 'var'},
        'int': {type: Token::INT_TYPE, literal: 'int'},
        'char': {type: Token::CHAR_TYPE, literal: 'char'},
        'boolean': {type: Token::BOOLEAN_TYPE, literal: 'boolean'},
        'void': {type: Token::VOID_TYPE, literal: 'void'},
        'true': {type: Token::TRUE, literal: 'true'},
        'false': {type: Token::FALSE, literal: 'false'},
        'null': {type: Token::NULL, literal: 'null'},
        'this': {type: Token::THIS, literal: 'this'},
        'let': {type: Token::LET, literal: 'let'},
        'do': {type: Token::DO, literal: 'do'},
        'if': {type: Token::IF, literal: 'if'},
        'else': {type: Token::ELSE, literal: 'else'},
        'while': {type: Token::WHILE, literal: 'while'},
        'return': {type: Token::RETURN, literal: 'return'},
      } }

      it 'should return right token' do
        assert_tokens keywords
      end
    end

    context 'when identifiers are given' do
      let(:identifiers) { {
        'variable': {type: Token::IDENT, literal: 'variable'},
        'tmp': {type: Token::IDENT, literal: 'tmp'},
      } }

      it 'should return right token' do
        assert_tokens identifiers
      end
    end

    context 'when digits are given' do
      let(:digits) { {
        '012345': {type: Token::INT, literal: '012345'},
        '3429579': {type: Token::INT, literal: '3429579'},
      } }

      it 'should return right token' do
        assert_tokens digits
      end
    end

    context 'when illegal symbols are given' do
      let(:digits) { {
        '#': {type: Token::ILLEGAL, literal: '#'},
        '@': {type: Token::ILLEGAL, literal: '@'},
      } }

      it 'should return right token' do
        assert_tokens digits
      end
    end

    context 'when multiple words are given' do
      context 'let statement' do
        context 'string expression' do
          let(:let_statements) do
            {'let str = "string constant!!";': [
              {type: Token::LET, literal: 'let'},
              {type: Token::IDENT, literal: 'str'},
              {type: Token::EQ, literal: '='},
              {type: Token::STRING, literal: 'string constant!!'},
              {type: Token::SEMICOLON, literal: ';'},
              {type: Token::EOF, literal: ''}
            ]}
          end

          it { assert_multiple_tokens let_statements }
        end

        context 'integer expression' do
          let(:let_statements) do
            {'let integeeer = 12345;': [
              {type: Token::LET, literal: 'let'},
              {type: Token::IDENT, literal: 'integeeer'},
              {type: Token::EQ, literal: '='},
              {type: Token::INT, literal: '12345'},
              {type: Token::SEMICOLON, literal: ';'},
              {type: Token::EOF, literal: ''}
            ]}
          end

          it { assert_multiple_tokens let_statements }
        end

        context 'integer calculation expression' do
          let(:let_statements) do
            {'let integeeer = 12345 + 36475;': [
              {type: Token::LET, literal: 'let'},
              {type: Token::IDENT, literal: 'integeeer'},
              {type: Token::EQ, literal: '='},
              {type: Token::INT, literal: '12345'},
              {type: Token::PLUS, literal: '+'},
              {type: Token::INT, literal: '36475'},
              {type: Token::SEMICOLON, literal: ';'},
              {type: Token::EOF, literal: ''}
            ]}
          end

          it { assert_multiple_tokens let_statements }
        end

        context 'do expression' do
          let(:let_statements) do
            {'let result = do someMethod(1238, someIntVar);': [
              {type: Token::LET, literal: 'let'},
              {type: Token::IDENT, literal: 'result'},
              {type: Token::EQ, literal: '='},
              {type: Token::DO, literal: 'do'},
              {type: Token::IDENT, literal: 'someMethod'},
              {type: Token::LPAREN, literal: '('},
              {type: Token::INT, literal: '1238'},
              {type: Token::COMMA, literal: ','},
              {type: Token::IDENT, literal: 'someIntVar'},
              {type: Token::RPAREN, literal: ')'},
              {type: Token::SEMICOLON, literal: ';'},
              {type: Token::EOF, literal: ''}
            ]}
          end

          it { assert_multiple_tokens let_statements }
        end
      end
    end
  end
end

private

def assert_tokens(expects)
  expects.each do |input, expected|
    token = Lexer.new(input).next_token

    expect(token.type).to eq expected[:type]
    expect(token.literal).to eq expected[:literal]
  end
end

# {'let a = "string constant"': [
#   {type: Token::LET, literal: 'let'},
#   {type: Token::IDENT, literal: 'a'},
#   {type: Token::EQ, literal: '='},
#   {type: Token::STRING, literal: 'string constant'}
# ]}
def assert_multiple_tokens(expects)
  expects.each do |input, tokens|
    l = Lexer.new(input)

    tokens.each do |expected|
      token = l.next_token
      expect(token.type).to eq expected[:type]
      expect(token.literal).to eq expected[:literal]
    end
  end
end