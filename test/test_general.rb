
require 'test/unit'
require 'truetypo'

class TrueTypoTest < Test::Unit::TestCase

  def test_return_type
    assert_true TrueTypo::fix('test').is_a? String
  end

  def test_multiplication_sign
    assert_equal '1×, 3×, 2 × 2, 10 × 10, 999 × 999, 1234 × 1234, 1 × 1000000', TrueTypo::fix_multiplication_sign('1x, 3X, 2 x 2, 10 x 10, 999x999, 1234 X 1234, 1X1000000')
  end

  def test_widows
    paragraph = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    paragraph_without_widow = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    assert_equal paragraph_without_widow, TrueTypo::fix_widows(paragraph)
  end

end
