
module Truty

  # Module with specific English typography fixes.
  # @author Matěj Kašpar Jirásek
  module English

    # Improves the English typography of single paragraph. If you supply more paragraphs you might lose some improvements like widows. For improving longer text see {General#fix}.
    #
    # @param input [String] The paragraph which will be converted.
    # @param country [String] The country ("uk" or "us").
    # @return [String] Paragraph with improved typography.
    def english(input, country = "us")
      input = add_soft_hyphens(input, "en_" + country)
      input = general(input)
      input = english_double_quotes(input)
      input = english_single_quotes(input)
    end

    # Converts single quotes to the typograhic ones.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct single quotes.
    def english_single_quotes(input)
      quotes(input, "'", "‘", "’")
    end

    # Converts double quotes to the typograhic ones.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct double quotes.
    def english_double_quotes(input)
      quotes(input)
    end

  end
end
