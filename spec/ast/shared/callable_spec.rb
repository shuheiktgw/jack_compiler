require 'spec_helper'

RSpec.shared_examples 'callable examples' do |klass|
  setup_generator
  subject do
    klass.new(token: 'oken_mock', prefix: prefix, function: function, arguments: arguments).to_vm(generator)
    File.read(path)
  end

  describe '#to_vm' do

    before do
      allow(generator).to receive(:method?) {is_method}
      allow(generator).to receive(:void?) {is_void}
      allow(function).to receive(:literal) {'someFunction'}
    end

    let(:arguments) {[IntegerLiteral.new(token: 'token_mock', value: 1), IntegerLiteral.new(token: 'token_mock', value: 2)]}
    let(:function) {double('function')}

    context 'without prefix' do
      let(:prefix) {nil}

      context 'when not method' do
        let(:is_method) {false}

        context 'method is not void' do
          let(:is_void) {false}

          it do
            expected = '' 'push constant 1
push constant 2
call TestClass.someFunction 2
' ''
            is_expected.to eq expected
          end
        end

        context 'method is void' do
          let(:is_void) {true}

          it do
            expected = '' 'push constant 1
push constant 2
call TestClass.someFunction 2
pop temp 0
' ''
            is_expected.to eq expected
          end
        end
      end

      context 'when method' do
        let(:is_method) {true}

        context 'method is not void' do
          let(:is_void) {false}

          it do
            expected = '' 'push pointer 0
push constant 1
push constant 2
call TestClass.someFunction 3
' ''
            is_expected.to eq expected
          end
        end

        context 'method is void' do
          let(:is_void) {true}

          it do
            expected = '' 'push pointer 0
push constant 1
push constant 2
call TestClass.someFunction 3
pop temp 0
' ''
            is_expected.to eq expected
          end
        end
      end
    end

    context 'with prefix' do
      before do
        allow(prefix).to receive(:literal) {'somePrefix'}
      end

      let(:prefix) {double('prefix')}

      context 'if prefix is not registered' do

        RSpec::Mocks.configuration.allow_message_expectations_on_nil = true

        let(:symbol_table_row) {nil}

        context 'when not method' do
          let(:is_method) {false}

          context 'method is not void' do
            let(:is_void) {false}

            it do
              expected = '' 'push constant 1
push constant 2
call somePrefix.someFunction 2
' ''
              is_expected.to eq expected
            end
          end

          context 'method is void' do
            let(:is_void) {true}

            it do
              expected = '' 'push constant 1
push constant 2
call somePrefix.someFunction 2
pop temp 0
' ''
              is_expected.to eq expected
            end
          end
        end

        context 'when method' do
          let(:is_method) {true}

          context 'method is not void' do
            let(:is_void) {false}

            it do
              pending('This should raise another error in production but now symbol table is mocked so...')
              expect {subject}.to raise_error('Uninitialized variable is given: somePrefix')
            end
          end

          context 'method is void' do
            let(:is_void) {true}

            it do
              pending('This should raise another error in production but now symbol table is mocked so...')
              expect {subject}.to raise_error('Uninitialized variable is given: somePrefix')
            end
          end
        end
      end

      context 'if prefix is registered' do
        let(:symbol_segment) {'local'}
        let(:symbol_index) {1}
        let(:symbol_type) {'SomeClass'}

        context 'when not method' do
          let(:is_method) {false}

          context 'method is not void' do
            let(:is_void) {false}

            it do
              expected = '' 'push constant 1
push constant 2
call SomeClass.someFunction 2
' ''
              is_expected.to eq expected
            end
          end

          context 'method is void' do
            let(:is_void) {true}

            it do
              expected = '' 'push constant 1
push constant 2
call SomeClass.someFunction 2
pop temp 0
' ''
              is_expected.to eq expected
            end
          end
        end

        context 'when method' do
          let(:is_method) {true}

          context 'method is not void' do
            let(:is_void) {false}

            it do
              expected = '' 'push local 1
push constant 1
push constant 2
call SomeClass.someFunction 3
' ''
              is_expected.to eq expected
            end
          end

          context 'method is void' do
            let(:is_void) {true}

            it do
              expected = '' 'push local 1
push constant 1
push constant 2
call SomeClass.someFunction 3
pop temp 0
' ''
              is_expected.to eq expected
            end
          end
        end
      end
    end
  end
end