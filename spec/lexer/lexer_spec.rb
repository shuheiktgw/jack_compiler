require 'spec_helper'

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