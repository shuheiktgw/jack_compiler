require 'spec_helper'
require './spec/to_vm_helper'
require './spec/ast/shared/callable_spec'

describe FunctionCall do
  include ToVmHelper
  it_behaves_like 'callable examples', FunctionCall
end
