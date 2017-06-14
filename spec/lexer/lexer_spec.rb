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
        symbols.each do |input, expected|
          token = Lexer.new(input).next_token
          expect(token.token_type).to eq expected[:token_type]
          expect(token.literal).to eq expected[:literal]
        end
      end
    end
  end
end