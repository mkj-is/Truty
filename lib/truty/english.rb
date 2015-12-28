
module Truty

  # Module with specific English typography fixes.
  # @author Matěj Kašpar Jirásek
  module English

    # Improves the English typography of single paragraph. If you supply more paragraphs you might lose some improvements like widows. For improving longer text see {General#fix}.
    #
    # @param input [String] The paragraph which will be converted.
    # @param convert [Array] Array of symbols with features that should be improved (possibilities: +all+, +hyphens+, +quotes+, +ellipsis+, +dashes+, +abbreviations+, +prepositions+, +numbers+, +dates+, +characters+, +brackets+, +multiplication+, +units+, +widows+)
    # @param country [String] The country ("uk" or "us").
    # @return [String] Paragraph with improved typography.
    def english(input, convert = [:all], country = "us")
      output = input
      output = soft_hyphens(output, "en_" + country) if (convert.include?(:all) || convert.include?(:hyphens))
      output = general(output, convert)
      output = english_double_quotes(output) if (convert.include?(:all) || convert.include?(:quotes))
      output = english_single_quotes(output) if (convert.include?(:all) || convert.include?(:quotes))
      output
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
