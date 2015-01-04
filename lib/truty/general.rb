
module General

  def fix(input, lang = "en_us")
    input.split("\n").collect { |p| fix_paragraph(p, lang) }.join("\n")
  end

  def fix_paragraph(input, lang = "en_us")
    output = input
    output = ellipsis(output)
    output = fix_multicharacters(output)
    output = fix_punctuation_whitespace(output)
    output = fix_brackets_whitespace(output)
    output = add_soft_hyphens(output, lang)
    output = emdash_spaces(output)
    output = endash_spaces(output)
    output = fix_double_quotes(output, "„", "“")
    output = fix_single_quotes(output, "‚", "‘")
    output = fix_multiplication_sign(output)
    output = fix_space_between_numbers(output)
    output = fix_units(output)
    output = fix_trailing_spaces(output)
    output = fix_widows(output)
  end

  def ellipsis(input)
    input.gsub(/\.{3,}/, "…")
  end

  def emdash_spaces(input)
    input.gsub(/\s+(—|-{2,3})\s+/, " — ")
  end

  def endash_spaces(input)
    input.gsub(/\s+(–|-)\s+/, " – ")
  end

  def add_soft_hyphens(input, lang = "en_us", left = 2, right = 2, char = "­")
    l = Text::Hyphen.new(:language => lang, :left => left, :right => right)
    words = input.split(/[ ]+/m)
    result = []
    words.each_with_index do |w, n|
      if !(w.length < 6 || n == words.size - 1 || w =~ URI::regexp || w =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
        w = l.visualise(w, char)
      end
      result << w
    end
    result.join(" ")
  end

  def fix_double_quotes(input, start_quotes = "“", end_quotes = "”")
    input.gsub(/"[^"]*"/) { |s| start_quotes + s[1..-2].strip + end_quotes }
  end

  def fix_single_quotes(input, start_quotes = "‘", end_quotes = "’")
    input.gsub(/'[^']*'/) { |s| start_quotes + s[1..-2].strip + end_quotes }
  end

  def fix_multiplication_sign(input)
    output = input.gsub(/(\d+)\s{0,1}[Xx]\s{0,1}(\d+)/, '\1 × \2')
    output = output.gsub(/(\d+)[Xx]/, '\1×')
  end

  def fix_space_between_numbers(input)
    input.gsub(/(\d)\s+(\d)/, '\1 \2')
  end

  def fix_brackets_whitespace(input)
    output = input.gsub(/([\(\[\{])\s*/, '\1')
    output = output.gsub(/\s*([\]\)\}])/, '\1')
    output = output.gsub(/\s+([\(\[\{])\s*/, ' \1')
    output = output.gsub(/\s*([\]\)\}])\s+/, '\1 ')
  end

  def fix_multicharacters(input)
    output = input.gsub(/\([Cc]\)/, "©")
    output = output.gsub(/\([Pp]\)/, "℗")
    output = output.gsub(/\([Rr]\)/, "®")
    output = output.gsub(/\((SM|sm|Sm)\)/, "℠")
    output = output.gsub(/\((TM|tm|Tm)\)/, "™")
    output = output.gsub(/\+-/, "±")
    output = output.gsub(/-\+/, "∓")
    output = output.gsub(/No.?\s*(\d+)/i, '№\1')
    output = output.gsub(/°C/, '℃')
    output = output.gsub(/°F/, '℉')
  end

  def fix_punctuation_whitespace(input)
    input.gsub(/\s*([\!\?\.,;:…]+)\s*/, '\1 ')
  end

  def fix_units(input)
    output = input.gsub(/(\d+)\s+(%|‰|‱|℃|℉|°|€|Kč|(Y|Z|E|P|T|G|M|k|h|da|d|m|µ|n|p|f|a|z|y)?(m(²|³)?|g|s|h|A|K|cd|mol|Ω|℃|℉))/, '\1 \2')
    output.gsub(/(\*|§|#|†)\s+(\d+)/, '\1 \2')
  end

  def fix_widows(input)
    input.gsub(/(\s)(\S+(\$|\z))/, ' \2')
  end

  def fix_trailing_spaces(input)
    input.gsub(/\s*($|\z)/, '')
  end

end
