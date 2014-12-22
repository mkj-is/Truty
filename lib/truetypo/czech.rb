
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
    output = fix_multiplication_sign(output)
    output = fix_space_between_numbers(output)
    output = fix_percentage(output)
    output = fix_long_czech_numbers(output)
    output = fix_czech_one_character_words(output)
  end

  def fix_czech_one_character_words(input)
    input.gsub(/\b([aikosuvz])\s/i, '\1 ')
  end

  def add_czech_soft_hyphens(input, left = 2, right = 2, char = "­")
    l = Text::Hyphen.new(:language => "cs", :left => left, :right => right)
    words = input.split(/[ ]+/m)
    result = []
    words.each_with_index do |w, n|
      if !(w.length < 6 || n == words.size - 1 || w =~ URI::regexp || w =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
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
      result << w
    end
    result.join(" ")
  end

  def fix_long_czech_numbers(input)
    input.gsub(/\d+/) { |n| n.reverse.scan(/(.{1,3})/).join(' ').reverse }
  end

end
