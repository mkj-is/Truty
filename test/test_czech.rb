
require 'test_helper'

class TrueTypoTest < Test::Unit::TestCase

  def test_one_character_words
    assert_equal 'S kluky v lese i u mostku a na dvoře. O prázdninách.', TrueTypo::fix_czech_one_character_words('S kluky v lese i u mostku a na dvoře. O prázdninách.')
  end

  def test_long_czech_numbers
    assert_equal '1, 12, 123, 1 234, 12 345, 123 456, 1 234 567, 12 345 678, 123 456 789, 0 123 456 789', TrueTypo::fix_long_czech_numbers('1, 12, 123, 1234, 12345, 123456, 1234567, 12345678, 123456789, 0123456789')
  end

  def test_czech_hyphenation_short_words
    words = 'Vstříc, FAMU, např., apod., oběd, éter, Ivan, .'
    assert_equal words, TrueTypo::add_czech_soft_hyphens(words)
  end

  def test_czech_hyphenation_long_words
    assert_not_equal 'jedenáctka, řeholník, slevnění, sardinka a typografie', TrueTypo::add_czech_soft_hyphens('jedenáctka, řeholník, slevnění, sardinka a typografie')
  end

  def test_czech_abbreviations
    assert_equal 'Např. zimnice. MgA. František Nedoma, PhD. Zábava apod. Tzn. diskriminace. 1000 př. n. l.', TrueTypo::fix_czech_abbreviations('Např. zimnice. MgA. František Nedoma, PhD. Zábava apod. Tzn. diskriminace. 1000 př. n. l.')
  end

  def test_full
    paragraph = 'Kdybyste hledali ostrůvek Tana Masa na mapě, našli byste jej právě na rovníku kousek na západ od Sumatry; ale kdybyste se zeptali na palubě lodi Kandong Bandoeng kapitána J. van Tocha, co to je tahle Tana Masa, před kterou právě zakotvil, nadával by chvíli a pak by vám řekl, že to je ta nejšpinavější díra v celých Sundských ostrovech, ještě mizernější než Tana Bala a přinejmenším tak zatracená jako Pini nebo Banjak; že jediný s odpuštěním člověk, který tam žije – nepočítáme-li ovšem tyhle všivé Bataky –, je opilý obchodní agent, kříženec mezi Kubu a Portugalcem a ještě větší zloděj, pohan a prase než celý Kubu a celý běloch dohromady; a že je-li na světě něco zatraceného, pak je to zatracený život na téhle zatracené Tana Masa, pane. Načež byste se ho patrně zeptali, proč tu tedy spustil ty zatracené kotvy, jako by tu chtěl zůstat zatracené tři dny; i zafuněl by podrážděně a bručel by něco v tom smyslu, že Kandong Bandoeng by sem neplula jenom pro tu zatracenou kopru nebo palmový olej, to dá rozum, a ostatně po tom vám nic není, pane, já mám své zatracené rozkazy, pane, a vy buďte tak laskav, pane, a hleďte si svého. A nadával by tak rozsáhle a hojně, jak se sluší na staršího, ale na svůj věk stále ještě svěžího lodního kapitána.'
    assert_not_equal paragraph, TrueTypo::czech(paragraph)
    assert_not_nil TrueTypo::czech(paragraph)
  end

end
