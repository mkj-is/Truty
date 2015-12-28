
module Truty

  # Module with specific French typography fixes.
  # @author Matěj Kašpar Jirásek
  module French

    # Improves the French typography of single paragraph. If you supply more paragraphs you might lose some improvements like widows. For improving longer text see {General#fix}.
    #
    # @param input [String] The paragraph which will be converted.
    # @param convert [Array] Array of symbols with features that should be improved (possibilities: +all+, +hyphens+, +quotes+, +ellipsis+, +dashes+, +abbreviations+, +prepositions+, +numbers+, +dates+, +characters+, +brackets+, +multiplication+, +units+, +widows+)
    # @return [String] Paragraph with improved typography.
    def french(input, convert = [:all])
      output = input
      output = soft_hyphens(output, "fr") if (convert.include?(:all) || convert.include?(:hyphens))
      output = general(output, convert)
      output = french_double_quotes(output) if (convert.include?(:all) || convert.include?(:quotes))
      output
    end

    # Converts double quotes to the typograhic ones, guillemets.
    #
    # @param input [String] The paragraph which will be converted.
    # @return [String] Paragraph with correct double quotes.
    def french_double_quotes(input)
      quotes(input, '"“”„«»', "« ", " »")
    end

  end
end
