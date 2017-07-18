require 'spec_helper'

describe ReturnStatement do
  let(:return_statement) { ReturnStatement.new(token: 'token', return_value: return_value) }

  describe '#to_h / to_xml' do
    subject(:hash) { return_statement.to_h }
    subject(:xml) { return_statement.to_xml }

    context 'return value is nil' do
      let(:return_value) { nil }

      it do
        expected = {
          returnStatement: {
            keyword: 'return',
            symbol: ';'
          }
        }

        expect(hash).to eq expected
      end

      it do
        expected = '<returnStatement><keyword>return</keyword><symbol>;</symbol></returnStatement>'
        expect(xml).to eq expected
      end
    end

    context 'return value is this' do
      let(:return_value) { ThisLiteral.new }

      it do
        expected = {
          returnStatement: {
            keyword: 'return',
            expression: {
              term: {
                keyword: 'this'
              }
            },
            symbol: ';'
          }
        }

        expect(hash).to eq expected
      end

      it do
        expected = '<returnStatement><keyword>return</keyword><expression><term><keyword>this</keyword></term></expression><symbol>;</symbol></returnStatement>'
        expect(xml).to eq expected
      end
    end
  end
end