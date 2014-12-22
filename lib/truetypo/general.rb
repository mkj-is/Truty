
module General

  def fix(input, lang = "en_us")
    input.split("\n").collect { |p| fix_paragraph(p, lang) }.join("\n")
  end

  def fix_paragraph(input, lang = "en_us")
    output = input
    output = ellipsis(output)
    output = fix_multicharacters(output)
    output = fix_brackets_whitespace(output)
    output = fix_punctuation_whitespace(output)
    output = add_soft_hyphens(output, lang)
    output = emdash_spaces(output)
    output = endash_spaces(output)
    output = fix_double_quotes(output, "„", "“")
    output = fix_single_quotes(output, "‚", "‘")
    output = fix_multiplication_sign(output)
    output = fix_space_between_numbers(output)
    output = fix_percentage(output)
    output = fix_widows(output)
  end

  def ellipsis(input)
    input.gsub(/\.\.\./) { "…" }
  end

  def emdash_spaces(input)
    input.gsub(/ (—|--) /) { " — " }
  end

  def endash_spaces(input)
    input.gsub(/ – /) { " – " }
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

  def fix_multiplication_sign(input)
    output = input.gsub(/(\d+)\s{0,1}[Xx]\s{0,1}(\d+)/, '\1 × \2')
    output = output.gsub(/(\d+)[Xx]/, '\1×')
  end

  def fix_space_between_numbers(input)
    input.gsub(/(\d)\s+(\d)/, '\1 \2')
  end

  def fix_brackets_whitespace(input)
    output = input.gsub(/\s*[\(\[\{]\s*/) { |s| " " + s.strip }
    output = output.gsub(/\s*[\]\)\}]\s*/) { |s| s.strip + " " }
  end

  def fix_multicharacters(input)
    output = input.gsub(/\([Cc]\)/) { "©" }
    output = output.gsub(/\([Pp]\)/) { "℗" }
    output = output.gsub(/\([Rr]\)/) { "®" }
    output = output.gsub(/\((SM|sm|Sm)\)/) { "℠" }
    output = output.gsub(/\((TM|tm|Tm)\)/) { "™" }
    output = output.gsub(/\+-/) { "±" }
    output = output.gsub(/-\+/) { "∓" }
  end

  def fix_punctuation_whitespace(input)
    input.gsub(/\s*([\!\?\.,;:…]+)\s*/, '\1 ')
  end

  def fix_percentage(input)
    output = input.gsub(/\d+ %/) { |s| s[0..s.length - 3] + " %" }
    output = output.gsub(/\d+ ‰/) { |s| s[0..s.length - 3] + " ‰" }
  end

  def fix_widows(input)
    input.gsub(/(\s)(\S+(\$|\z))/, ' \2')
  end

end
