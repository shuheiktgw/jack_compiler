require 'spec_helper'

describe Loader do
  describe '#load_next' do
    context 'when file exists' do
      let(:loader) {Loader.new(path)}

      context 'when path is file' do
        let(:path) {File.expand_path('../jack_codes/test.jack', __FILE__)}

        context 'call load_next once' do
          subject { loader.load_next }

          it 'should return file content' do
            is_expected.to eq "test\ntest\ntest"
          end
        end

        context 'call load_next twice' do
          subject do
            loader.load_next
            loader.load_next
          end

          it 'should return nil' do
            is_expected.to be_nil
          end
        end
      end

      context 'when path is directory' do
        let(:path) {File.expand_path('../jack_codes/test', __FILE__)}

        context 'call load_next once' do
          subject { loader.load_next }

          it 'should return first file content' do
            is_expected.to eq "test1\ntest1\ntest1"
          end
        end

        context 'call load_next twice' do
          subject do
            loader.load_next
            loader.load_next
          end

          it 'should return second file content' do
            is_expected.to eq "test2\ntest2\ntest2"
          end
        end

        context 'call load_next three times' do
          subject do
            loader.load_next
            loader.load_next
            loader.load_next
          end

          it 'should return nil' do
            is_expected.to be_nil
          end
        end
      end
    end

    context 'when file does not exist' do

      it 'should raise error' do
        expect{ Loader.new(File.expand_path('../jack_codes/unknown.jack', __FILE__)) }
      end
    end
  end
end