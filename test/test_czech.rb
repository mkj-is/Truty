
require 'test/unit'
require 'truetypo'

class TrueTypoTest < Test::Unit::TestCase

  def test_one_character_words
    assert_equal 'S kluky v lese i u mostku a na dvoře. O prázdninách.', TrueTypo::czech('S kluky v lese i u mostku a na dvoře. O prázdninách.')
  end

end
