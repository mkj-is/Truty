
module Truty

  # Module with general typography fixes for all the languages. The fixes in here should not be language specific.
  # @author Matěj Kašpar Jirásek
  module General

    # Improves the typography of the large plain text with paragraphs. Adds non-breaking spaces, hyphenation, fixes dashes, etc.
    #
    # @param input [String] The text which will be converted.
    # @param lang [Symbol] Sets the language (english name like "czech", "german", etc.)
    # @return [String] Text with improved typography.
    def fix(input, lang = :general)
      if not Truty.respond_to? lang then
        lang = :general
      end
      input.split("\n").collect { |p| Truty.send lang, p }.join("\n")
    end

    # Improves basic non-language specific issues in typography.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with improved typography.
    def general(input)
      input = ellipsis(input)
      input = multicharacters(input)
      input = punctuation_whitespace(input)
      input = brackets_whitespace(input)
      input = emdash(input)
      input = endash(input)
      input = name_abbreviations(input)
      input = multiplication_sign(input)
      input = space_between_numbers(input)
      input = units(input)
      input = trailing_spaces(input)
      input = widows(input)
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
    def emdash(input)
      input.gsub(/\s+(—|-{2,3})\s+/, " — ")
    end

    # Adds non-breaking space before endash.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with corrected endashes.
    def endash(input)
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
    def soft_hyphens(input, lang = "en_us", left = 2, right = 2, char = "­")
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

    # Converts quotes to the typograhic ones.
    #
    # @param input [String] The paragraph which will be converted.
    # @param type [String] Character which will be substited for correct quotes.
    # @param start_quotes [String] The character used for starting quotes.
    # @param end_quotes [String] The character used for ending quotes.
    # @return [String] Paragraph with correct double quotes.
    def quotes(input, type = '"“”„', start_quotes = "“", end_quotes = "”")
      regexp = Regexp.new('[' + type + '][^' + type + ']*[' + type + ']')
      input.gsub(regexp) { |s| start_quotes + s[1..-2].gsub(/(^[\s ]+|[\s ]+$)/, "") + end_quotes }
    end

    # Adds multiplication sign between numbers instead of X.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct multiplication signs.
    def multiplication_sign(input)
      output = input.gsub(/(\d+)\s{0,1}[Xx]\s{0,1}(\d+)/, '\1 × \2')
      output = output.gsub(/(\d+)[Xx]/, '\1×')
    end

    # Adds thin non-breaking space between numbers.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct spaces between numbers.
    def space_between_numbers(input)
      input.gsub(/(\d)\s+(\d)/, '\1 \2')
    end

    # Fixes spaces around various brackets.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct spaces around brackets.
    def brackets_whitespace(input)
      output = input.gsub(/([\(\[\{])\s*/, '\1')
      output = output.gsub(/\s*([\]\)\}])/, '\1')
      output = output.gsub(/\s+([\(\[\{])\s*/, ' \1')
      output = output.gsub(/\s*([\]\)\}])\s+/, '\1 ')
    end

    # Tries to substitute more characters which should be one, like "©", "™", etc.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with converted characters.
    def multicharacters(input)
      output = input.gsub(/\([Cc]\)/, "©")
      output = output.gsub(/\([Pp]\)/, "℗")
      output = output.gsub(/\([Rr]\)/, "®")
      output = output.gsub(/\((SM|sm|Sm)\)/, "℠")
      output = output.gsub(/\((TM|tm|Tm)\)/, "™")
      output = output.gsub(/\+-/, "±")
      output = output.gsub(/-\+/, "∓")
      output = output.gsub(/N[oO]\.?\s*(\d+)/, '№\1')
      output = output.gsub(/°C/, '℃')
      output = output.gsub(/°F/, '℉')
    end

    # Fixes spaces around punctuation.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct spaces around punctuation.
    def punctuation_whitespace(input)
      input.gsub(/\s*([\!\?\.,;:…]+)\s*/, '\1 ')
    end

    # Fixes non-breaking spaces betwwen number and unit.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct spaces between number and unit.
    def units(input)
      output = input.gsub(/(\d+)\s+(%|‰|‱|℃|℉|°|€|Kč|(Y|Z|E|P|T|G|M|k|h|da|d|m|µ|n|p|f|a|z|y)?(m(²|³)?|g|s|h|A|K|cd|mol|Ω|℃|℉))/, '\1 \2')
      output.gsub(/(\*|§|#|†)\s+(\d+)/, '\1 \2')
    end

    # Adds non-breaking space before the last word in the paragraph.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with removed widows.
    def widows(input)
      input.gsub(/(\s)(\S+(\$|\z))/, ' \2')
    end

    # Removes whitespace after the end of the paragraph.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph without trailing spaces.
    def trailing_spaces(input)
      input.gsub(/\s*($|\z)/, '')
    end

    # Adds non-breaking space after one-character name abbreviation ("A.", "J.", etc.)
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with non-breaking spaces after name abbreviations.
    def name_abbreviations(input)
      input.gsub(/(\s|^)(([A-Z]\.\s+)+)/) { $1 + $2.gsub(/ +/, " ")}
    end

  end
end
