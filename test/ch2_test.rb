require 'test/unit'
require 'ch_2'

class Ch2Test < Test::Unit::TestCase

  def test_number
    assert Number.new(42).value == 42
  end
end
