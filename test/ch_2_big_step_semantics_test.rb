require 'test/unit'
require 'ch_2_big_step_semantics'

class Ch2BigStepSemanticsTest < Test::Unit::TestCase

  def test_number
    assert Number.new(23).evaluate({}).to_s == "23"
  end

  def test_variable
    assert Variable.new(:x).evaluate({ x: Number.new(23) }).to_s == "23"
  end

  def test_less_than
    assert LessThan.new(
      Add.new(Variable.new(:x), Number.new(2)),
      Variable.new(:y)
    ).evaluate({ x: Number.new(2), y: Number.new(5) }).to_s == "true"
  end

  def test_sequence
    statement = Sequence.new(
      Assign.new(:x, Add.new(Number.new(1), Number.new(1))),
      Assign.new(:y, Add.new(Variable.new(:x), Number.new(3))))

    assert statement.evaluate({}).to_s == '{:x=>"2", :y=>"5"}'
  end

  def test_while
    statement = While.new(
      LessThan.new(Variable.new(:x), Number.new(5)),
      Assign.new(:x, Multiply.new(Variable.new(:x), Number.new(3))))

    assert statement.evaluate({ x: Number.new(1) }).to_s == '{:x=>"9"}'
  end
end
