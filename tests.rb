#!/usr/bin/ruby

require 'htmlentities'
require "./truetypo.rb"

s = '"A není tu někde kousek břehu," ptal se kapitán, "kde tihle Batakové nelezou do vody?"
Kříženec mezi Kubu a Portugalcem vrtěl hlavou. "Není, pane. Leda Devil Bay, ale to pro vás nic není."'

c = TrueTypo.czech(s)
coder = HTMLEntities.new
html = coder.encode(c, :decimal)
print html
