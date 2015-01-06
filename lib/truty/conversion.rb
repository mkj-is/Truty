
require 'htmlentities'

module Truty

  # Module with conversion engine for plain text. Converts to HTML.
  # @author Matěj Kašpar Jirásek
  module Conversion

    # Fixes the typography and also converts the string.
    #
    # @param input [String] Text input.
    # @param conversion [Symbol] Coversion type ("html" or "none")
    # @return [String] Fixed and converted text.
    def convert(input, conversion = :html, lang = :general)
      if Truty.respond_to? conversion then
        Truty.send(conversion, Truty.fix(input, lang))
      end
    end

    # Escapes string to HTML entities.
    #
    # @param input [String] Text input.
    # @return [String] Text with HTML entities.
    def html(input)
      coder = HTMLEntities.new
      coder.encode(input, :named, :decimal)
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
