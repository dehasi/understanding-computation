require 'test/unit'
require 'ch_2_big_step_semantics'

class Ch2BigStepSemanticsTest < Test::Unit::TestCase

  def test_number
    number_new = Number.new(23)
    p number_new
    p number_new.evaluate({})
    assert number_new.evaluate({}).to_s == "23"
  end

  def test_variable
    number_new = Number.new(23)
    p number_new
    p number_new.evaluate({})
    assert number_new.evaluate({}).to_s == "23"
  end
end
