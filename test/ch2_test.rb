require 'test/unit'
require 'ch_2'

class Ch2Test < Test::Unit::TestCase

  def test_number
    assert Number.new(42).value == 42
  end

  def test_build_expresstion
    exp = Add.new(
      Multiply.new(Number.new(1), Number.new(2)),
      Multiply.new(Number.new(3), Number.new(4)))

    puts exp
  end
end
