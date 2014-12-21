
module Czech

  def czech(input)
    output = input
    output = ellipsis(output)
    output = fix_multicharacters(output)
    output = fix_brackets_whitespace(output)
    output = fix_punctuation_whitespace(output)
    output = add_czech_soft_hyphens(output)
    output = emdash_spaces(output)
    output = endash_spaces(output)
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
    words = input.split(/[ ]+/m)
    n = 0
    words.each do |w|
      if !(w.length < 6 || w =~ URI::regexp || w =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
        w = l.visualise(w, char)
      end
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