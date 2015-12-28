
require 'test_helper'

class TrutyFrenchTest < Test::Unit::TestCase

  def test_english
    paragraph = 'Elle est arrivée à destination. Devant elle le grand Château de Versailles où Louis XIV, le Roi Soleil, organisa ses fêtes et vécut la grande vie entouré de ses maîtresses. À droite se trouve l\'avenue de St.-Cloud, où est situé l\'appartement dans lequel elle va vivre avec Josephine. Fatiguée, mais joyeuse, elle commence à chercher l\'adresse de l\'appartement. «Toute seule dans un nouveau pays, ne connaissant personne, l\'avenir, je t\'embrasse vivement!» se dit Lucie.'
    assert_not_equal paragraph, Truty.french(paragraph)
    assert_not_nil Truty.french(paragraph)
  end

  def test_english_text
    text = 'Elle est arrivée à destination.
Fatiguée, mais joyeuse, elle commence à chercher l\'adresse de l\'appartement.'
    converted = Truty.fix(text, :french)
    assert_not_equal text, converted
    assert_equal text.count("\n"), converted.count("\n")
  end

  def test_english_double_quotes
    assert_equal '« Toute seule dans un nouveau pays, ne connaissant personne, l\'avenir, je t\'embrasse vivement! » se dit Lucie.', Truty.french_double_quotes('"Toute seule dans un nouveau pays, ne connaissant personne, l\'avenir, je t\'embrasse vivement!" se dit Lucie.')
  end

end
