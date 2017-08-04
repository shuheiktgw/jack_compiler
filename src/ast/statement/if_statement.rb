require_relative '../ast_base'

class IfStatement < AstBase

  attr_reader :token, :condition, :consequence, :alternative

  def initialize(token:, condition:, consequence:, alternative:)
    @token = token
    @condition = condition
    @consequence = consequence
    @alternative = alternative
  end

  def to_vm(generator)
    # condition
    condition.to_vm(generator)

    to_else = generator.generate_label
    to_end = generator.generate_label

    generator.write_command('~')
    alternative ? generator.write_if_goto(to_else) : generator.write_if_goto(to_end)

    # consequence
    consequence.to_vm(generator)
    generator.write_goto(to_end)

    # alternative
    generator.write_label(to_else)
    alternative.to_vm(generator)
    generator.write_label(to_end)
  end
end