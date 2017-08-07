module ToVmHelper

  def self.included(c)
    c.extend ClassMethods
  end

  module ClassMethods

    def setup_generator
      let(:klass) { double('klass') }
      let(:symbol_table) { double('symbol_table') }
      let(:function_table) { double('function_table') }
      let(:writer) { Writer.new(File.expand_path('./test_output/test.vm', __FILE__)) }
      let(:generator){ Generator.new(klass: klass, symbol_table: symbol_table, function_table: function_table, writer: writer) }

      before do
        allow(klass).to receive_message_chain(:class_name, :literal) { 'TestClass' }
      end
    end
  end
end