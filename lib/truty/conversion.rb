
require 'htmlentities'

module Truty
  module Conversion

    def convert(input, conversion = :html, lang = :general)
      if Truty.respond_to? conversion then
        Truty.send(conversion, Truty.fix(input, lang))
      end
    end

    def html(input)
      coder = HTMLEntities.new
      coder.encode(input, :named, :decimal)
    end

    def none(input)
      input
    end

  end
end
