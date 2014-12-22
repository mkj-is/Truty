
require 'test/unit'
require 'truetypo'

class TrueTypoTest < Test::Unit::TestCase

  def test_one_character_words
    assert_equal 'S kluky v lese i u mostku a na dvoře. O prázdninách.', TrueTypo::fix_czech_one_character_words('S kluky v lese i u mostku a na dvoře. O prázdninách.')
  end

  def test_long_czech_numbers
    assert_equal '1, 12, 123, 1 234, 12 345, 123 456, 1 234 567, 12 345 678, 123 456 789, 0 123 456 789', TrueTypo::fix_long_czech_numbers('1, 12, 123, 1234, 12345, 123456, 1234567, 12345678, 123456789, 0123456789')
  end

  def test_czech_hyphenation_short_words
    words = 'Vstříc, FAMU, např., apod., oběd, éter, Ivan.'
    assert_equal words, TrueTypo::add_czech_soft_hyphens(words)
  end

  def test_czech_hyphenation_long_words
    assert_not_equal 'jedenáctka, řeholník, slevnění, sardinka a typografie', TrueTypo::czech('jedenáctka, řeholník, slevnění, sardinka a typografie')
  end

end
