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

  def test_machine_run_number
    result = Machine.new(Add.new(
      Multiply.new(Number.new(1), Number.new(2)),
      Multiply.new(Number.new(3), Number.new(4))), {}
    ).run

    assert_equal 14, result.value
  end

  def test_machine_run_boolean
    result = Machine.new(
      LessThan.new(Number.new(5), Add.new(Number.new(2), Number.new(2))), {}
    ).run

    assert_false result.value
  end

  def test_machine_run_variable
    result = Machine.new(
      Add.new(Variable.new(:x), Variable.new(:y)),
      { x: Number.new(3), y: Number.new(4) }
    ).run

    assert_equal 7, result.value
  end

  def test_assignment
    result = Machine.new(
      Assign.new(:x, Add.new(Variable.new(:x), Number.new(1))), { x: Number.new(2) }
    ).run

    assert result.instance_of? DoNothing
  end

  def test_if
    result = Machine.new(If.new(
      Variable.new(:x),
      Assign.new(:y, Number.new(1)),
      Assign.new(:y, Number.new(2))
    ), { x: Boolean.new(true) }
    ).run

    assert result.instance_of? DoNothing
  end
end
