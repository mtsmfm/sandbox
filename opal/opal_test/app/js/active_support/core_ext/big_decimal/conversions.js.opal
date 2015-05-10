class BigDecimal
  class << self
    def new(val)
      `Number(#{val})`
    end
  end
end

def BigDecimal(value)
  BigDecimal.new(value)
end
