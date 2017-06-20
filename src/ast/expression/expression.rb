class Expression

  EXPRESSION_XML = 'expression'.freeze

  # https://github.com/savonrb/gyoku
  def initialize(terms)
    @terms = terms
  end

  def to_h
    ts = @terms.map{|t| t.to_h}

    {
      EXPRESSION_XML => ts
    }
  end
end