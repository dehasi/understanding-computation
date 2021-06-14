require 'test/unit'
require 'ch_2_big_step_semantics'

class Ch2BigStepSemanticsTest < Test::Unit::TestCase

  def test_number
    assert Number.new(23).evaluate({}).to_s == "23"
  end

  def test_variable
    assert Variable.new(:x).evaluate({ x: Number.new(23) }).to_s == "23"
  end

  def test_lessThan
    assert LessThan.new(
      Add.new(Variable.new(:x), Number.new(2)),
      Variable.new(:y)
    ).evaluate({ x: Number.new(2), y: Number.new(5) }).to_s == "true"
  end
end
