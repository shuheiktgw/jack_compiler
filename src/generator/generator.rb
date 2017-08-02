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
    table.notify_method_change(declaration.method_name)
  end

  def write_let(statement)
    statement.expression.to_vm(self)
    
    segment, index = translate_identifier(statement.identifier.value)
    writer.write_pop(segment: segment, index: index)
  end

  def translate_identifier(variable_name)
    row = table.find(variable_name)
    segment = translate_declaration(row.declaration_type)
    index = row.index

    [segment, index]
  end

  def translate_declaration(declaration_type)
    case declaration_type
    when 'argument'
      'arg'
    when 'field'
      'this'
    else
      declaration_type
    end
  end

  def write_expression(expression)
    expression.to_vm(self)

  end
end