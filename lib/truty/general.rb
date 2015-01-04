
module Truty

  # Module with general typography fixes for all the languages. The fixes in here should not be language specific.
  # @author Matěj Kašpar Jirásek
  module General

    # Improves the typography of the large plain text with paragraphs. Adds non-breaking spaces, hyphenation, fixes dashes, etc.
    #
    # @param input [String] The text which will be converted.
    # @param lang [String] Sets the language of hyphenation. (See {#add_soft_hyphens}.)
    # @return [String] Text with improved typography.
    def fix(input, lang = "en_us")
      input.split("\n").collect { |p| fix_paragraph(p, lang) }.join("\n")
    end

    # Improves the typography of single paragraph. If you supply more paragraphs you might lose some improvements like widows. For improving longer text see {#fix}.
    #
    # @param input [String] The paragraph which will be converted.
    # @param lang [String] Sets the language of hyphenation. (See {#add_soft_hyphens}.)
    # @return [String] Paragraph with improved typography.
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

    # Converts three or more periods (dots, points) into ellipsis.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with ellipses.
    def ellipsis(input)
      input.gsub(/\.{3,}/, "…")
    end

    # Adds thin spaces to emdash from both sides. Also converts two or three hyphens to emdash.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with corrected emdashes.
    def emdash_spaces(input)
      input.gsub(/\s+(—|-{2,3})\s+/, " — ")
    end

    # Adds non-breaking space before endash.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with corrected endashes.
    def endash_spaces(input)
      input.gsub(/\s+(–|-)\s+/, " – ")
    end

    # Adds soft hyphens to the input.
    #
    # @param input [String] The paragraph which will be converted.
    # @param lang [String] Sets the language of hyphenation. One of the languages a {http://www.rubydoc.info/gems/text-hyphen/ text-hyphen gem} can use.
    # @param left [Integer] Number of characters on the beginning of the words which cannnot be hyphenated.
    # @param right [Integer] Number of characters on the beginning of the words which cannnot be hyphenated.
    # @param char [Integer] The character which will be added to hyphenation places.
    # @return [String] Paragraph with added hyphenation characters.
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

    # Converts simple double quotes to the typograhic ones.
    #
    # @param input [String] The paragraph which will be converted.
    # @param start_quotes [String] The character used for starting quotes.
    # @param end_quotes [String] The character used for ending quotes.
    # @return [String] Paragraph with correct double quotes.
    def fix_double_quotes(input, start_quotes = "“", end_quotes = "”")
      input.gsub(/"[^"]*"/) { |s| start_quotes + s[1..-2].strip + end_quotes }
    end

    # Converts simple single quotes to the typograhic ones.
    #
    # @param input [String] The paragraph which will be converted.
    # @param start_quotes [String] The character used for starting quotes.
    # @param end_quotes [String] The character used for ending quotes.
    # @return [String] Paragraph with correct single quotes.
    def fix_single_quotes(input, start_quotes = "‘", end_quotes = "’")
      input.gsub(/'[^']*'/) { |s| start_quotes + s[1..-2].strip + end_quotes }
    end

    # Adds multiplication sign between numbers instead of X.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct multiplication signs.
    def fix_multiplication_sign(input)
      output = input.gsub(/(\d+)\s{0,1}[Xx]\s{0,1}(\d+)/, '\1 × \2')
      output = output.gsub(/(\d+)[Xx]/, '\1×')
    end

    # Adds thin non-breaking space between numbers.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct spaces between numbers.
    def fix_space_between_numbers(input)
      input.gsub(/(\d)\s+(\d)/, '\1 \2')
    end

    # Fixes spaces around various brackets.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct spaces around brackets.
    def fix_brackets_whitespace(input)
      output = input.gsub(/([\(\[\{])\s*/, '\1')
      output = output.gsub(/\s*([\]\)\}])/, '\1')
      output = output.gsub(/\s+([\(\[\{])\s*/, ' \1')
      output = output.gsub(/\s*([\]\)\}])\s+/, '\1 ')
    end

    # Tries to substitute more characters which should be one, like "©", "™", etc.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with converted characters.
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

    # Fixes spaces around punctuation.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct spaces around punctuation.
    def fix_punctuation_whitespace(input)
      input.gsub(/\s*([\!\?\.,;:…]+)\s*/, '\1 ')
    end

    # Fixes non-breaking spaces betwwen number and unit.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct spaces between number and unit.
    def fix_units(input)
      output = input.gsub(/(\d+)\s+(%|‰|‱|℃|℉|°|€|Kč|(Y|Z|E|P|T|G|M|k|h|da|d|m|µ|n|p|f|a|z|y)?(m(²|³)?|g|s|h|A|K|cd|mol|Ω|℃|℉))/, '\1 \2')
      output.gsub(/(\*|§|#|†)\s+(\d+)/, '\1 \2')
    end

    # Adds non-breaking space before the last word in the paragraph.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with removed widows.
    def fix_widows(input)
      input.gsub(/(\s)(\S+(\$|\z))/, ' \2')
    end

    # Removes whitespace after the end of the paragraph.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph without trailing spaces.
    def fix_trailing_spaces(input)
      input.gsub(/\s*($|\z)/, '')
    end

  end
end
