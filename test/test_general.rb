
require 'test_helper'

class TrutyGeneralTest < Test::Unit::TestCase

  def test_return_type
    assert Truty.fix('test').is_a? String
  end

  def test_non_existing_language
    assert Truty.fix('test', :kokorean).is_a? String
  end

  def test_ellipsis
    assert_equal "Nuda… Nuda… Ach, to je nuda…", Truty.ellipsis("Nuda... Nuda.... Ach, to je nuda......")
  end

  def test_emdash
    assert_equal "One — or the other. Or — else. Totally — I mean it.", Truty.emdash("One — or the other. Or -- else. Totally --- I mean it.")
  end

  def test_endash
    assert_equal "One – or the other. Or – else. Totally – I mean it.", Truty.endash("One – or the other. Or - else. Totally - I mean it.")
  end

  def test_multiplication_sign
    assert_equal '1×, 3×, 2 × 2, 10 × 10, 999 × 999, 1234 × 1234, 1 × 1000000', Truty.multiplication_sign('1x, 3X, 2 x 2, 10 x 10, 999x999, 1234 X 1234, 1X1000000')
  end

  def test_widows
    paragraph = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    paragraph_without_widow = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    assert_equal paragraph_without_widow, Truty.widows(paragraph)
  end

  def test_units
    assert_equal "50 %, § 23, # 26, * 1921, † 2000, 100 m², 10 kg, 19 ℃, 1 000 000 Kč, 250 €", Truty.units("50  %, § 23, # 26, *  1921, † 2000, 100 m², 10 kg, 19 ℃, 1 000 000  Kč, 250 €")
  end

  def test_multicharacters
    assert_equal "©℗®℠™№1©℗®℠™№2℃℉±∓", Truty.multicharacters("(c)(p)(r)(sm)(tm)No.1(C)(P)(R)(Sm)(Tm)No.2°C°F+--+")
  end

  def test_brackets
    assert_equal "This is a sentence (and some more information). (Whole sentence.) No way. {10 + [5 + (10 - 2) + (x + y) - 555] + [45 + (30 - 3) + 5] + 55}", Truty::brackets_whitespace("This is a sentence (   and some more information  ). (Whole sentence. )  No way. {  10 + [ 5 + (    10 - 2) +    (  x + y ) - 555 ] + [ 45 + ( 30 - 3 ) + 5   ]   + 55 }")
  end

  def test_trailing_spaces
    assert_equal "This is a test paragraph.", Truty.trailing_spaces("This is a test paragraph.      ")
  end

  def test_hyphenation
    text = 'One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his bed into a horrible vermin.'
    assert text.length < Truty.soft_hyphens(text).length
  end

  def test_double_quotes
    assert_equal '“Hello,” he said, “I come from the deep ocean.” “Pretty cool!” she answered.', Truty.quotes('"Hello," he said, "I come from the deep ocean." "Pretty cool!" she answered.')
  end

  def test_single_quotes
    assert_equal "\"‘Hello,’ he said, ‘I come from the deep ocean.’ ‘Pretty cool!’ she answered. And that was their story from my point of view.\"", Truty.quotes("\"'Hello,' he said, 'I come from the deep ocean.' 'Pretty cool!' she answered. And that was their story from my point of view.\"", "'", "‘", "’")
  end

  def test_punctuation
    assert_equal 'Hello! How are you? Boring… Still; Not: Angry. ', Truty.punctuation_whitespace('Hello   ! How are you ?  Boring   …   Still ;  Not: Angry   .')
  end

  def test_space_between_numbers
    assert_equal '1 000 000, +420 737 87 97 17', Truty.space_between_numbers('1 000 000, +420 737 87 97 17')
  end

  def test_name_abbreviations
    assert_equal 'J. van Koch, J. D., B. Pitt, J. R. R. Tolkien', Truty.name_abbreviations('J. van Koch, J. D., B. Pitt, J. R. R. Tolkien')
  end

  def test_weblinks
    assert_equal 'google.cz, hola-hola.hr, www.mkj.is', Truty.fix('google.cz, hola-hola.hr, www.mkj.is')
  end

  def test_smileys
    assert_equal 'Ahoj :) Jak se máš? :D', Truty.fix('Ahoj :) Jak se máš? :D')
  end

end
