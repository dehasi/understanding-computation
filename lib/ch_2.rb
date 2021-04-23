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
      Number.new(left.value * right.value) #??
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

  def reduce(environment)
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

class DoNothing

  def ==(other_statement)
    other_statement.instance_of?(DoNothing)
  end

  def reducible?
    false
  end

  def to_s
    'do-nothing'
  end

  def inspect
    "\"#{self}\""
  end
end

class Assign < Struct.new(:name, :expression)

  def reduce(environment)
    if expression.reducible?
      [Assign.new(name, expression.reduce(environment)), environment]
    else
      [DoNothing.new, environment.merge({ name => expression })]
    end
  end

  def reducible?
    true
  end

  def to_s
    "#{name} = #{expression}"
  end

  def inspect
    "\"#{self}\""
  end
end

class If < Struct.new(:condition, :consequence, :alternative)

  def reduce(environment)
    if condition.reducible?
      [If.new(condition.reduce(environment), consequence, alternative), environment]
    else
      case condition
      when Boolean.new(true)
        [consequence, environment]
      when Boolean.new(false)
        [alternative, environment]
      end
    end
  end

  def reducible?
    true
  end

  def to_s
    "if (#{condition}) { #{consequence} } else { #{alternative} }"
  end

  def inspect
    "\"#{self}\""
  end
end

class Machine < Struct.new(:statement, :environment)

  def step
    # puts "DEBUG: #{statement}, #{environment}, #{statement.class}"
    if statement.instance_of?(Assign) or statement.instance_of?(If)
      self.statement, self.environment = statement.reduce(environment)
    else
      self.statement = statement.reduce(environment)
    end
    # puts "DEBUG: #{statement}, #{environment}, #{statement.class}"
  end

  def run
    while statement.reducible?
      puts "#{statement}, #{environment}"
      step
    end
    puts "#{statement}, #{environment}"
    statement
  end
end