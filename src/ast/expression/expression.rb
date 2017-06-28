class Expression

  # https://github.com/savonrb/gyoku
  def initialize(terms)
    @terms = terms
  end

  def to_h
    ts = @terms.map{|t| t.to_h}

    {
      expression: ts
    }
  end
end