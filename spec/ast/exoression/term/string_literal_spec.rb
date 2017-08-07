require 'spec_helper'
require_relative '../../../to_vm_helper'

describe StringLiteral do
  include ToVmHelper

  setup_generator
  subject{ File.read(path) }

  describe '#to_vm' do
    it 'should translate string into series of commands' do
      StringLiteral.new(token: 'token_mock', value: 'Score: 0').to_vm(generator)

      expected = '''push constant 8
call String.new 1
push constant 83
call String.appendChar 2
push constant 99
call String.appendChar 2
push constant 111
call String.appendChar 2
push constant 114
call String.appendChar 2
push constant 101
call String.appendChar 2
push constant 58
call String.appendChar 2
push constant 32
call String.appendChar 2
push constant 48
call String.appendChar 2
'''

      is_expected.to eq expected
    end
  end
end