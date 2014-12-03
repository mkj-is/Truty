#!/usr/bin/ruby

# Requires the text-hyphen gem (tested with ruby 2.1.5 and gem version 1.4.1)

require 'text/hyphen'

module General

  def ellipsis(input)
    input.gsub(/\.\.\./) { "…" }
  end

  def emdash_spaces(input)
    input.gsub(/ (—|--) /) { " — " }
  end

  def add_soft_hyphens(input, lang = "en_us", left = 2, right = 2, char = "­")
    l = Text::Hyphen.new(:language => lang, :left => left, :right => right)
    l.visualise(input, char)
  end

  def fix_double_quotes(input, start_quotes = "“", end_quotes = "”")
    input.gsub(/"[^"]*"/) { |s| start_quotes + s[1..-2].strip + end_quotes }
  end

  def fix_single_quotes(input, start_quotes = "‘", end_quotes = "’")
    input.gsub(/'[^']*'/) { |s| start_quotes + s[1..-2].strip + end_quotes }
  end

  def fix_times(input)
    input.gsub(/\d+x/) { |s| s[0..-2] + "×"}
  end

  def fix_brackets_whitespace(input)
    output = input.gsub(/\s*[\(\[\{]\s*/) { |s| " " + s.strip }
    output = output.gsub(/\s*[\]\)\}]\s*/) { |s| s.strip + " " }
  end

  def fix_multicharacters(input)
    output = input.gsub(/\([Cc]\)/) { "©" }
    output = output.gsub(/\([Pp]\)/) { "℗" }
    output = output.gsub(/\([Rr]\)/) { "®" }
    output = output.gsub(/\((SM|sm)\)/) { "℠" }
    output = output.gsub(/\((TM|tm)\)/) { "™" }
    output = output.gsub(/\+-/) { "±" }
    output = output.gsub(/-\+/) { "∓" }
  end

  def fix_punctuation_whitespace(input)
    input.gsub(/\s*[\!\?\.,;:…]\s*/) { |s| s.strip + " " }
  end

  def fix_percentage(input)
    output = input.gsub(/\d+ %/) { |s| s[0..s.length - 3] + " %" }
    output = output.gsub(/\d+ ‰/) { |s| s[0..s.length - 3] + " ‰" }
  end

end

module Czech

  def czech(input)
    output = input
    output = ellipsis(output)
    output = fix_multicharacters(output)
    output = fix_punctuation_whitespace(output)
    output = fix_brackets_whitespace(output)
    output = add_czech_soft_hyphens(output)
    output = emdash_spaces(output)
    output = fix_double_quotes(output, "„", "“")
    output = fix_single_quotes(output, "‚", "‘")
    output = fix_times(output)
    output = one_character_words(output)
    output = fix_percentage(output)
  end

  def one_character_words(input)
    input.gsub(/\W[aikosuvz] /i) { |s| s[0..1] + " "}
  end

  def add_czech_soft_hyphens(input, left = 2, right = 2, char = "­")
    l = Text::Hyphen.new(:language => "cs", :left => left, :right => right)
    words = l.visualise(input, char).split(/\s+/m)
    n = 0
    words.each do |w|
      for i in (w.length - right)..w.length do
        if w[i] == char
          w[i] = ""
        end
      end
      for i in 0..left do
        if w[i] == char
          w[i] = ""
        end
      end
      words[n] = w
      n += 1
    end
    words.join(" ")
  end

end

module TrueTypo

  extend General
  extend Czech

end

