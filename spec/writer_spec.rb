require 'spec_helper'

describe Writer do
  let(:writer) {Writer.new(path)}
  let(:path) {File.expand_path('../test_output/test.vm', __FILE__)}

  describe '#write_push' do
    context 'if valid segment is given' do
      let(:segment) { 'const' }

      it 'should return valid vm code' do
        writer.write_push(segment: segment, index: 0)
        expect(File.read(path)).to eq "push const 0\n"
      end
    end

    context 'if invalid segment is given' do
      let(:segment) { 'invalid' }

      it 'should raise error' do
        expect{ writer.write_push(segment: segment, index: 0) }.to raise_error('invalid segment is selected: invalid')
      end
    end
  end

  describe '#write_pop' do
    context 'if valid segment is given' do
      let(:segment) { 'local' }

      it 'should return valid vm code' do
        writer.write_pop(segment: segment, index: 0)
        expect(File.read(path)).to eq "pop local 0\n"
      end
    end

    context 'if invalid segment is given' do
      let(:segment) { 'invalid' }

      it 'should raise error' do
        expect{ writer.write_pop(segment: segment, index: 0) }.to raise_error('invalid segment is selected: invalid')
      end
    end
  end

  describe '#write_arithmetic' do
    context 'if valid segment is given' do
      let(:command) { 'add' }

      it 'should return valid vm code' do
        writer.write_arithmetic(command)
        expect(File.read(path)).to eq "add\n"
      end
    end

    context 'if invalid command is given' do
      let(:command) { 'somethingGreat' }

      it 'should raise error' do
        expect{ writer.write_arithmetic(command) }.to raise_error('invalid command is given: somethingGreat')
      end
    end
  end

  describe '#write_label' do
    let(:label) { 'END' }

    it 'should return valid vm code' do
      writer.write_label(label)
      expect(File.read(path)).to eq "label END\n"
    end
  end

  describe '#write_goto' do
    let(:label) { 'END' }

    it 'should return valid vm code' do
      writer.write_goto(label)
      expect(File.read(path)).to eq "goto END\n"
    end
  end

  describe '#write_call' do
    it 'should return valid vm code' do
      writer.write_call(name: 'test', number: '12')
      expect(File.read(path)).to eq "call test 12\n"
    end
  end

  describe '#write_function' do
    it 'should return valid vm code' do
      writer.write_function(name: 'test', number: '12')
      expect(File.read(path)).to eq "function test 12\n"
    end
  end
end