
require 'test_helper'

class TrueTypoTest < Test::Unit::TestCase

  def test_return_type
    assert_true TrueTypo::fix('test').is_a? String
  end

  def test_ellipsis
    assert_equal "Nuda… Nuda… Ach, to je nuda…", TrueTypo::ellipsis("Nuda... Nuda.... Ach, to je nuda......")
  end

  def test_emdash
    assert_equal "One — or the other. Or — else. Totally — I mean it.", TrueTypo::emdash_spaces("One — or the other. Or -- else. Totally --- I mean it.")
  end

  def test_endash
    assert_equal "One – or the other. Or – else. Totally – I mean it.", TrueTypo::endash_spaces("One – or the other. Or - else. Totally - I mean it.")
  end

  def test_multiplication_sign
    assert_equal '1×, 3×, 2 × 2, 10 × 10, 999 × 999, 1234 × 1234, 1 × 1000000', TrueTypo::fix_multiplication_sign('1x, 3X, 2 x 2, 10 x 10, 999x999, 1234 X 1234, 1X1000000')
  end

  def test_widows
    paragraph = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    paragraph_without_widow = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    assert_equal paragraph_without_widow, TrueTypo::fix_widows(paragraph)
  end

  def test_units
    assert_equal "50 %, § 23, # 26, * 1921, † 2000, 100 m², 10 kg, 19 ℃, 1 000 000 Kč, 250 €", TrueTypo::fix_units("50  %, § 23, # 26, *  1921, † 2000, 100 m², 10 kg, 19 ℃, 1 000 000  Kč, 250 €")
  end

  def test_multicharacters
    assert_equal "©℗®℠™№1©℗®℠™№2℃℉±∓", TrueTypo::fix_multicharacters("(c)(p)(r)(sm)(tm)No.1(C)(P)(R)(Sm)(Tm)No.2°C°F+--+")
  end

  def test_brackets
    assert_equal "This is a sentence (and some more information). (Whole sentence.) No way. {10 + [5 + (10 - 2) + (x + y) - 555] + [45 + (30 - 3) + 5] + 55}", TrueTypo::fix_brackets_whitespace("This is a sentence (   and some more information  ). (Whole sentence. )  No way. {  10 + [ 5 + (    10 - 2) +    (  x + y ) - 555 ] + [ 45 + ( 30 - 3 ) + 5   ]   + 55 }")
  end

  def test_trailing_spaces
    assert_equal "This is a test paragraph.", TrueTypo::fix_trailing_spaces("This is a test paragraph.      ")
  end

  def test_hyphenation
    text = 'One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his bed into a horrible vermin.'
    assert_true text.length < TrueTypo::add_soft_hyphens(text).length
  end

  def test_double_quotes
    assert_equal '“Hello,” he said, “I come from the deep ocean.” “Pretty cool!” she answered.', TrueTypo::fix_double_quotes('"Hello," he said, "I come from the deep ocean." "Pretty cool!" she answered.')
  end

  def test_single_quotes
    assert_equal "\"‘Hello,’ he said, ‘I come from the deep ocean.’ ‘Pretty cool!’ she answered. And that was their story from my point of view.\"", TrueTypo::fix_single_quotes("\"'Hello,' he said, 'I come from the deep ocean.' 'Pretty cool!' she answered. And that was their story from my point of view.\"")
  end

  def test_punctuation
    assert_equal 'Hello! How are you? Boring… Still; Not: Angry. ', TrueTypo::fix_punctuation_whitespace('Hello   ! How are you ?  Boring   …   Still ;  Not: Angry   .')
  end

  def test_space_between_numbers
    assert_equal '1 000 000, +420 737 87 97 17', TrueTypo::fix_space_between_numbers('1 000 000, +420 737 87 97 17')
  end

end
