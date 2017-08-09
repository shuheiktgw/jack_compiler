module Callable
  private

  def write_arguments(generator)
    @generator = generator

    if method?
      if prefix_literal
        r = generator.find_symbol(prefix_literal)
        generator.write_push(segment: r.segment, index: r.index)
      else
        generator.write_push(segment: 'pointer', index: 0)
      end
    end

    arguments.each{ |a| a.to_vm(generator) }
  end

  def function_name
    "#{klass_name}.#{function.literal}"
  end

  def arguments_count
    if method?
      arguments.count + 1
    else
      arguments.count
    end
  end

  def method?
    generator.method?(klass_name: klass_name, method_name: function.literal)
  end

  def void?
    generator.void?(klass_name: klass_name, method_name: function.literal)
  end

  def klass_name
    return @klass_name if @klass_name

    @klass_name = if prefix_literal
      r = generator.find_symbol(prefix, false)

      if r
        r.type
      else
        prefix_literal
      end
    else
      generator.klass_name
    end
  end

  def prefix_literal
    unless instance_variable_defined? :@prefix_literal
      @prefix_literal = prefix ? prefix.literal : nil
    end

    @prefix_literal
  end

  def generator
    @generator
  end
end