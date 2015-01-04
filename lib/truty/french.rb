
module Truty

  # Module with specific French typography fixes.
  # @author Matěj Kašpar Jirásek
  module French

    # Improves the French typography of single paragraph. If you supply more paragraphs you might lose some improvements like widows. For improving longer text see {General#fix}.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with improved typography.
    def french(input)
      input = soft_hyphens(input, "fr")
      input = general(input)
      input = french_double_quotes(input)
      input = french_single_quotes(input)
    end

    # Converts single quotes to the typograhic ones.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct single quotes.
    def french_single_quotes(input)
      quotes(input, "'", "‹ ", " ›")
    end

    # Converts double quotes to the typograhic ones.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct double quotes.
    def french_double_quotes(input)
      quotes(input, "\"", "« ", " »")
    end

  end
end
