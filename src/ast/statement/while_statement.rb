require_relative '../ast_base'

class WhileStatement < AstBase

  attr_reader :token, :condition, :consequence

  def initialize(token:, condition:, consequence:)
    @token = token
    @condition = condition
    @consequence = consequence
  end

  def to_vm(generator)
    to_start = generator.generate_label
    to_end   = generator.generate_label

    generator.write_label(to_start)
    condition.to_vm(generator)

    generator.write_command('~')
    generator.write_if(to_end)

    consequence.to_vm(generator)
    generator.write_goto(to_start)
    generator.write_label(to_end)
  end
end