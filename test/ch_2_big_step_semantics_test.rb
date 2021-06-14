require 'test/unit'
require 'ch_2_big_step_semantics'

class Ch2BigStepSemanticsTest < Test::Unit::TestCase

  def test_number
    assert Number.new(23).evaluate({}).to_s == "23"
  end

  def test_variable
    assert Variable.new(:x).evaluate({ x: Number.new(23) }).to_s == "23"
  end
end
