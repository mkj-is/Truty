#!/usr/bin/ruby

require 'htmlentities'
require "./truetypolib.rb"

s = 'Kdybyste hledali ostrůvek Tana Masa na mapě, našli byste jej právě na rovníku kousek na západ od Sumatry; ale kdybyste se zeptali na palubě lodi Kandong Bandoeng kapitána J. van Tocha, co to je tahle Tana Masa, před kterou právě zakotvil, nadával by chvíli a pak by vám řekl, že to je ta nejšpinavější díra v celých Sundských ostrovech, ještě mizernější než Tana Bala a přinejmenším tak zatracená jako Pini nebo Banjak; že jediný s odpuštěním člověk, který tam žije – nepočítáme-li ovšem tyhle všivé Bataky –, je opilý obchodní agent, kříženec mezi Kubu a Portugalcem a ještě větší zloděj, pohan a prase než celý Kubu a celý běloch dohromady; a že je-li na světě něco zatraceného, pak je to zatracený život na téhle zatracené Tana Masa, pane. Načež byste se ho patrně zeptali, proč tu tedy spustil ty zatracené kotvy, jako by tu chtěl zůstat zatracené tři dny; i zafuněl by podrážděně a bručel by něco v tom smyslu, že Kandong Bandoeng by sem neplula jenom pro tu zatracenou kopru nebo palmový olej, to dá rozum, a ostatně po tom vám nic není, pane, já mám své zatracené rozkazy, pane, a vy buďte tak laskav, pane, a hleďte si svého. A nadával by tak rozsáhle a hojně, jak se sluší na staršího, ale na svůj věk stále ještě svěžího lodního kapitána.'

c = TrueTypo.czech(s)
coder = HTMLEntities.new
html = coder.encode(c, :decimal)
print html
