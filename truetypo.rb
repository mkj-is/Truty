#!/usr/bin/ruby

require "./truetypolib.rb"

def main
  puts TrueTypo.czech(ARGF.read)
end

main()
