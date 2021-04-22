class Number < Struct.new(:value)

  def reducible?
    false
  end

  def to_s
    value.to_s
  end

  def inspect
    "«#{self}»"
  end
end

class Add < Struct.new(:left, :right)

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