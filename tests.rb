#!/usr/bin/ruby

require "./truetypo.rb"

s = '"A není tu někde kousek břehu," ptal se kapitán, "kde tihle Batakové nelezou do vody?"
Kříženec mezi Kubu a Portugalcem vrtěl hlavou. "Není, pane. Leda Devil Bay, ale to pro vás nic není."'

print TrueTypo.czech(s)
