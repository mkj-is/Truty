
require 'htmlentities'

module Truty

  # Module with conversion engine for plain text. Converts to HTML.
  # @author Matěj Kašpar Jirásek
  module Conversion

    # Fixes the typography and also converts the string.
    #
    # @param input [String] Text input.
    # @param conversion [Symbol] Conversion type ("html" or "none")
    # @param convert [Array] Array of symbols with features that should be improved (possibilities: +all+, +hyphens+, +quotes+, +ellipsis+, +dashes+, +abbreviations+, +prepositions+, +numbers+, +dates+, +characters+, +brackets+, +multiplication+, +units+, +widows+)
    # @return [String] Fixed and converted text.
    def convert(input, conversion = :html, lang = :general, convert = [:all])
      if !Truty.respond_to? conversion then
        conversion = :none
      end
      Truty.send(conversion, Truty.fix(input, lang, convert))
    end

    # Escapes string to HTML entities.
    #
    # @param input [String] Text input.
    # @return [String] Text with HTML entities.
    def html(input)
      coder = HTMLEntities.new
      coder.encode(input, :named, :decimal)
    end

    # Returns hash with Czech HTML entities as keys and values as their respective human readable versions.
    #
    # @return [Hash] Hash with entities.
    def czech_diacritics
      {
        "&aacute;" => "á",
        "&#269;" => "č",
        "&#271;" => "ď",
        "&eacute;" => "é",
        "&#283;" => "ě",
        "&iacute;" => "í",
        "&#328;" => "ň",
        "&oacute;" => "ó",
        "&#345;" => "ř",
        "&scaron;" => "š",
        "&#357;" => "ť",
        "&uacute;" => "ú",
        "&#367;" => "ů",
        "&yacute;" => "ý",
        "&#382;" => "ž",
      }
    end

    # Escapes string to readable Czech HTML entities.
    #
    # @param input [String] Text input.
    # @return [String] Text with HTML entities.
    def czech_html(input)
      coder = HTMLEntities.new
      encoded = coder.encode(input, :named, :decimal)
      czech_diacritics.each { |k, v| encoded.gsub!(k, v) }
      encoded
    end

    # Returns the input as it is.
    #
    # @param input [String] Input for conversion.
    # @return [String] Not changed string from input.
    def none(input)
      input
    end

  end
end
