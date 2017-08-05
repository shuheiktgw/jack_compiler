require 'spec_helper'
require 'ostruct'

describe FunctionTable::FunctionTable do
  let(:klass) {double('klass')}
  let(:method1) {double('method_token')}
  let(:method2) {double('method_body')}
  let(:function_table) { FunctionTable::FunctionTable.new(klass) }

  before do
    allow(klass).to receive_message_chain(:class_name, :literal) { 'SomeClass' }
    allow(klass).to receive(:methods) { [method1, method2] }
    allow(method1).to receive_message_chain(:type, :literal) { 'void' }
    allow(method1).to receive_message_chain(:method_name, :literal) { 'voidMethod' }
    allow(method2).to receive_message_chain(:type, :literal) { 'String' }
    allow(method2).to receive_message_chain(:method_name, :literal) { 'stringMethod' }
  end

  describe '#void?' do
    context 'when known method is specified' do
      subject { function_table.void?(klass_name: klass_name, method_name: method_name) }

      context 'when void method is specified' do
        let(:klass_name) { 'SomeClass' }
        let(:method_name) { 'voidMethod' }

        it 'should return true' do
          is_expected.to be_truthy
        end
      end

      context 'when String method is specified' do
        let(:klass_name) { 'SomeClass' }
        let(:method_name) { 'stringMethod' }

        it 'should return false' do
          is_expected.to be_falsey
        end
      end
    end

    context 'when unknown method is specified' do
      let(:klass_name) { 'SomeClass' }
      let(:method_name) { 'unknown' }

      it 'should raise error' do
        expect { function_table.void?(klass_name: klass_name, method_name: method_name) }.to raise_error('Unknown method has been specified: SomeClass.unknown')
      end
    end
  end
end