require 'test/unit'
require 'ch_2'

class Ch2Test < Test::Unit::TestCase

  def test_number
    assert Number.new(42).value == 42
  end

  def test_build_expression
    exp = Add.new(
      Multiply.new(Number.new(1), Number.new(2)),
      Multiply.new(Number.new(3), Number.new(4)))

    assert_equal exp.to_s, '1 * 2 + 3 * 4'
  end

  def test_machine_run
    result = Machine.new(Add.new(
      Multiply.new(Number.new(1), Number.new(2)),
      Multiply.new(Number.new(3), Number.new(4)))
    ).run

    assert_equal 14, result.value
  end
end
