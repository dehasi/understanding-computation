class Number < Struct.new(:value)
  def evaluate(environment)
    self
  end

  def to_s
    value.to_s
  end

  def inspect
    "\"#{self}\""
  end
end

class Boolean < Struct.new(:value)
  def evaluate(environment)
    self
  end

  def to_s
    value.to_s
  end

  def inspect
    "\"#{self}\""
  end
end

class Variable < Struct.new(:name)
  def evaluate(environment)
    environment[name]
  end

  def to_s
    name.to_s
  end

  def inspect
    "\"#{self}\""
  end
end

class Add < Struct.new(:left, :right)
  def evaluate(environment)
    Number.new(left.evaluate(environment).value + right.evaluate(environment).value)
  end

  def to_s
    "#{left} + #{right}"
  end

  def inspect
    "\"#{self}\""
  end
end

class Multiply < Struct.new(:left, :right)
  def evaluate(environment)
    Number.new(left.evaluate(environment).value * right.evaluate(environment).value)
  end

  def to_s
    "#{left} * #{right}"
  end

  def inspect
    "\"#{self}\""
  end
end

class LessThan < Struct.new(:left, :right)
  def evaluate(environment)
    Boolean.new(left.evaluate(environment).value < right.evaluate(environment).value)
  end

  def to_s
    "#{left} < #{right}"
  end

  def inspect
    "\"#{self}\""
  end
end

class Assign < Struct.new(:name, :expression)

  def evaluate(environment)
    environment.merge({ name => expression.evaluate(environment) })
  end

  def to_s
    "#{name} = #{expression}"
  end

  def inspect
    "\"#{self}\""
  end
end

class DoNothing
  def evaluate(environment)
    environment
  end

  def to_s
    "do-nothing"
  end

  def inspect
    "\"#{self}\""
  end
end

class If < Struct.new(:condition, :consequence, :alternative)

  def evaluate(environment)
    case condition.evaluate(environment)
    when Boolean.new(true)
      consequence.evaluate(environment)
    when Boolean.new(false)
      alternative.evaluate(environment)
    end
  end

  def to_s
    "if (#{condition}) { #{consequence} } else { #{alternative} }"
  end

  def inspect
    "\"#{self}\""
  end
end

class Sequence < Struct.new(:first, :second)
  def evaluate(environment)
    second.evaluate(first.evaluate(environment))
  end
end

class While < Struct.new(:condition, :body)
  def evaluate(environment)
    case condition.evaluate(environment)
    when Boolean.new(true)
      evaluate(body.evaluate(environment))
    when Boolean.new(false)
      environment
    end
  end
end
