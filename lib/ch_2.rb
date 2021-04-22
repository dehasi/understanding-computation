class Number < Struct.new(:value)

  def reducible?
    false
  end

  def to_s
    value.to_s
  end

  def inspect
    "\"#{self}\""
  end
end

class Add < Struct.new(:left, :right)

  def reduce(environment)
    if left.reducible?
      Add.new(left.reduce(environment), right)
    elsif right.reducible?
      Add.new(left, right.reduce(environment))
    else
      Number.new(left.value + right.value)
    end
  end

  def reducible?
    true
  end

  def to_s
    "#{left} + #{right}"
  end

  def inspect
    "«#{self}»"
  end
end

class Multiply < Struct.new(:left, :right)

  def reduce(environment)
    if left.reducible?
      Multiply.new(left.reduce(environment), right)
    elsif right.reducible?
      Multiply.new(left, right.reduce(environment))
    else
      Number.new(left.value * right.value)
    end
  end

  def reducible?
    true
  end

  def to_s
    "#{left} * #{right}"
  end

  def inspect
    "«#{self}»"
  end
end

class Boolean < Struct.new(:value)
  def reducible?
    false
  end

  def to_s
    value.to_s
  end

  def inspect
    "\"#{self}\""
  end
end

class LessThan < Struct.new(:left, :right)

  def reduce(environment)
    if left.reducible?
      LessThan.new(left.reduce(environment), right)
    elsif right.reducible?
      LessThan.new(left, right.reduce(environment))
    else
      Boolean.new(left.value < right.value)
    end
  end

  def reducible?
    true
  end

  def to_s
    "#{left} < #{right}"
  end

  def inspect
    "«#{self}»"
  end
end

class Variable < Struct.new(:name)

  def reduce(environment)(environment)
    environment[name]
  end

  def reducible?
    true
  end

  def to_s
    name.to_s
  end

  def inspect
    "\"#{self}\""
  end
end

class Machine < Struct.new(:expression, :environment)

  def step
    self.expression = expression.reduce(environment)
  end

  def run
    while expression.reducible?
      puts expression
      step
    end
    puts expression
    expression
  end
end