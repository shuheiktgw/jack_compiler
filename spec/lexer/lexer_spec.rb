require 'spec_helper'

describe Lexer do
  describe '# next_token' do
    context 'when symbols are given' do
      let(:symbols) { {
        '=': {token_type: Token::EQ, literal: '='},
        '~': {token_type: Token::NOT, literal: '~'},
        '+': {token_type: Token::PLUS, literal: '+'},
        '-': {token_type: Token::MINUS, literal: '-'},
        '*': {token_type: Token::ASTERISK, literal: '*'},
        '/': {token_type: Token::SLASH, literal: '/'},
        '<': {token_type: Token::LT, literal: '<'},
        '>': {token_type: Token::GT, literal: '>'},
        '&': {token_type: Token::AND, literal: '&'},
        '|': {token_type: Token::OR, literal: '|'},
        '.': {token_type: Token::PERIOD, literal: '.'},
        ',': {token_type: Token::COMMA, literal: ','},
        ';': {token_type: Token::SEMICOLON, literal: ';'},
        '(': {token_type: Token::LPAREN, literal: '('},
        ')': {token_type: Token::RPAREN, literal: ')'},
        '{': {token_type: Token::LBRACE, literal: '{'},
        '}': {token_type: Token::RBRACE, literal: '}'},
        '[': {token_type: Token::LBRACK, literal: '['},
        ']': {token_type: Token::RBRACK, literal: ']'},
        '': {token_type: Token::EOF, literal: ''},
      } }

      it 'should return a right token' do
        assert_tokens symbols
      end
    end

    context 'when keywords are given' do
      let(:keywords) { {
        'class': {token_type: Token::CLASS, literal: 'class'},
        'constructor': {token_type: Token::CONSTRUCTOR, literal: 'constructor'},
        'function': {token_type: Token::FUNCTION, literal: 'function'},
        'method': {token_type: Token::METHOD, literal: 'method'},
        'field': {token_type: Token::FIELD, literal: 'field'},
        'static': {token_type: Token::STATIC, literal: 'static'},
        'var': {token_type: Token::VAR, literal: 'var'},
        'int': {token_type: Token::INT_TYPE, literal: 'int'},
        'char': {token_type: Token::CHAR_TYPE, literal: 'char'},
        'boolean': {token_type: Token::BOOLEAN_TYPE, literal: 'boolean'},
        'void': {token_type: Token::VOID_TYPE, literal: 'void'},
        'true': {token_type: Token::TRUE, literal: 'true'},
        'false': {token_type: Token::FALSE, literal: 'false'},
        'null': {token_type: Token::NULL, literal: 'null'},
        'this': {token_type: Token::THIS, literal: 'this'},
        'let': {token_type: Token::LET, literal: 'let'},
        'do': {token_type: Token::DO, literal: 'do'},
        'if': {token_type: Token::IF, literal: 'if'},
        'else': {token_type: Token::ELSE, literal: 'else'},
        'while': {token_type: Token::WHILE, literal: 'while'},
        'return': {token_type: Token::RETURN, literal: 'return'},
      } }

      it 'should return right token' do
        assert_tokens keywords
      end
    end
  end
end

private

def assert_tokens(expects)
  expects.each do |input, expected|
    token = Lexer.new(input).next_token

    expect(token.token_type).to eq expected[:token_type]
    expect(token.literal).to eq expected[:literal]
  end
end