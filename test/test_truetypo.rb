
require "test/unit"
require 'truetypo'

class TrueTypoTest < Test::Unit::TestCase

  def test_multiplication_sign
    assert_equal '1×, 3×, 2 × 2, 10 × 10, 999 × 999, 1234 × 1234, 1 × 1000000', TrueTypo::fix('1x, 3X, 2 x 2, 10 x 10, 999x999, 1234 X 1234, 1X1000000')
  end

end
