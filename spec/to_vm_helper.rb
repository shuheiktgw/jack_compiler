module ToVmHelper

  # TODO Refactor this by shared context!!!!!!!!!!
  def self.included(c)
    c.extend ClassMethods
  end

  module ClassMethods

    def setup_generator
      let(:klass) { double('klass') }

      let(:symbol_table) { double('symbol_table') }
      let(:symbol_table_row) { double('symbol_table_row') }
      let(:symbol_segment) { nil }
      let(:symbol_index) { nil }
      let(:symbol_type) { nil }

      let(:function_table) { double('function_table') }

      let(:writer) { Writer.new(path) }
      let(:path) { File.expand_path('../test_output/test.vm', __FILE__) }
      let(:generator){ Generator.new(klass: klass, symbol_table: symbol_table, function_table: function_table, writer: writer) }

      before do
        allow(klass).to receive_message_chain(:class_name, :literal) { 'TestClass' }

        allow(symbol_table).to receive(:find) { symbol_table_row }
        allow(symbol_table_row).to receive(:segment) { symbol_segment }
        allow(symbol_table_row).to receive(:index) { symbol_index }
        allow(symbol_table_row).to receive(:type) { symbol_type }

        allow(function_table).to receive(:void?) { is_void }
      end
    end
  end
end