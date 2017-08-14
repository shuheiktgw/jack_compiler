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

    to_true = generator.generate_label
    to_false = generator.generate_label
    to_end = generator.generate_label

    generator.write_if(to_true)
    alternative ? generator.write_goto(to_false) : generator.write_goto(to_end)

    # consequence
    generator.write_label(to_true)
    consequence.to_vm(generator)

    # alternative
    if alternative
      generator.write_goto(to_end)
      generator.write_label(to_false)
      alternative.to_vm(generator)
    end

    generator.write_label(to_end)
  end
end