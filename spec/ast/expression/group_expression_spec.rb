require 'spec_helper'

describe GroupExpression do
  let(:group_expression) { GroupExpression.new(expression: expression) }

  describe '#to_h / #to_xml' do
    subject(:hash) { group_expression.to_h }
    subject(:xml) { group_expression.to_xml }

  end
end