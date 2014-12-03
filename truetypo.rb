#!/usr/bin/ruby

# Requires the text-hyphen gem (tested with ruby 2.1.5 and gem version 1.4.1)

require 'text/hyphen'

module General

  def ellipsis(input)
    input.gsub(/\.\.\./) { |s| "…" }
  end

  def emdash_spaces(input)
    input.gsub(/ (—|--) /) { |s| " — " }
  end

  def add_soft_hyphens(input, lang = "en_us", left = 2, right = 2, char = "­")
    l = Text::Hyphen.new(:language => lang, :left => left, :right => right)
    l.visualise(input, char)
  end

  def fix_double_quotes(input, start_quotes = "“", end_quotes = "”")
    input.gsub(/"[^"]*"/) { |s| start_quotes + s[1..-2] + end_quotes }
  end

  def fix_single_quotes(input, start_quotes = "‘", end_quotes = "’")
    input.gsub(/'[^']*'/) { |s| start_quotes + s[1..-2] + end_quotes }
  end

end

module Czech

  def czech(input)
    output = input
    output = add_soft_hyphens(output, "cs", 2, 2, "-")
    output = ellipsis(output)
    output = emdash_spaces(output)
    output = one_character_words(output)
    output = fix_double_quotes(output, "„", "“")
    output = fix_single_quotes(output, "‚", "‘")
  end

  def one_character_words(input)
    input.gsub(/ [aikosuvAIKOSUV] /) { |s| " " + s.strip + " "}
  end

end

module TrueTypo

  extend General
  extend Czech

end

