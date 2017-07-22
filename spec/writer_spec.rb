require 'spec_helper'

describe Writer do
  describe '#execute' do
    let(:writer) {Writer.new(path, 'test')}
    let(:path) {File.expand_path('../test_output/test.xml', __FILE__)}

    it do
      writer.execute
      expect(File.read(path)).to eq 'test'
    end
  end
end