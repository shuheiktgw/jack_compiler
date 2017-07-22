require 'spec_helper'

describe VarDeclaration do
  let(:var_declaration) {VarDeclaration.new(token: 'token', type: type, identifier: Token.new(type: Token::IDENT, literal: 'someVar'))}

  describe '#to_h / #to_xml' do
    subject(:hash) {var_declaration.to_h}
    subject(:xml) {var_declaration.to_xml}

    context 'type is identifier' do
      let(:type) {Token.new(type: Token::IDENT, literal: 'Square')}

      it do
        expected = {
          var_dec: [
            {keyword: 'var'},
            {identifier: 'Square'},
            {identifier: 'someVar'},
            {symbol: ';'}
          ]
        }

        expect(hash).to eq expected
      end

      it do
        expected = '<varDec><keyword>var</keyword><identifier>Square</identifier><identifier>someVar</identifier><symbol>;</symbol></varDec>'
        expect(xml).to eq expected
      end
    end

    context 'type is keyword' do
      let(:type) {Token.new(type: Token::BOOLEAN_TYPE, literal: 'boolean')}

      it do
        expected = {
          var_dec: [
            {keyword: 'var'},
            {keyword: 'boolean'},
            {identifier: 'someVar'},
            {symbol: ';'}
          ]
        }

        expect(hash).to eq expected
      end

      it do
        expected = '<varDec><keyword>var</keyword><keyword>boolean</keyword><identifier>someVar</identifier><symbol>;</symbol></varDec>'
        expect(xml).to eq expected
      end
    end
  end
end