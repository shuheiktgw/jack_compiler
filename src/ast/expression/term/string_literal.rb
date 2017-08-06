require_relative '../../ast_base'

class StringLiteral < AstBase

  attr_reader :token, :value

  def initialize(token:, value:)
    @token = token
    @value = value
  end

  def to_vm(generator)
    generator.write_push(segment: 'constant', index: value.length)
    generator.write_call(name: 'String.new', number: 1)

    value.each_char do |c|
      generator.push(segment: 'const', index: c.ord)
      generator.write_call(name: 'String.appendChar', number: 2)
    end
  end
end