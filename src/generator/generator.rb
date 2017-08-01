class Generator

  attr_reader :klass, :klass_name, :table, :writer

  def initialize(klass:,table:, writer:)
    @klass = klass
    @klass_name = klass.class_name
    @table = table
    @writer = writer
  end

  def execute
    klass.to_vm(self)
  end

  def write_function(declaration)
    writer.write_function(name: "#{klass_name}.#{declaration.method_name}", number: declaration.parameters.count)
    table.notify_method_change(name)
  end
end