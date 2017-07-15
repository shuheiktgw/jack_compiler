class InfixExpression < AstBase

  attr_reader :token, :left, :operator, :right

  def initialize(token:, left:, operator:, right:)
    @token = token
    @left = left
    @operator = operator
    @right = right
  end

  # Hmm, this is ugly but...
  def to_h
    binding.pry

    if left.to_h.has_key? :expression

      [
        { symbol: symbol },
        right.to_h
      ]

    else
      {
        expression: [
          left.to_h,
          { symbol: operator },
          right.to_h
        ]
      }
    end


    # base = [
    #   { symbol: symbol },
    #   right.to_h
    # ]
    #
    # if left.has_key? :expression
    #   left.expression << base
    #   left.to_h
    # else
    #   {
    #     expression: base
    #   }
    # end
  end
end