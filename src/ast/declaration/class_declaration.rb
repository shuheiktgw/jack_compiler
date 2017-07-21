class ClassDeclaration < AstBase
  attr_reader :token, :class_name, :variables, :methods

  def initialize(token:, class_name:, variables:, methods:)
    @token = token
    @class_name = class_name
    @variables = variables
    @methods = methods
  end

  def to_h
    {
      class: [
        {keyword: 'class'},
        {identifier: class_name.literal},
        {symbol: '{'},
        variables,
        methods,
        {symbol: '}'}
      ].flatten
    }
  end
end