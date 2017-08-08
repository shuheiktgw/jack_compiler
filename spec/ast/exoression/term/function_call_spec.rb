require 'spec_helper'
require_relative '../../../to_vm_helper'

describe FunctionCall do
  include ToVmHelper

  setup_generator
  subject{ File.read(path) }

  describe '#to_vm' do

    before do
      FunctionCall.new(token: token, prefix: prefix, function: function, arguments: arguments).to_vm(generator)
    end

    context 'not function' do
      let(:token) {  }

    end

    context 'function' do
      let(:token) {  }

    end
  end
end