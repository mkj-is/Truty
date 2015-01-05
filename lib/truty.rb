#!/usr/bin/ruby

require 'uri'
require 'text/hyphen'
require 'truty/general'
require 'truty/conversion'
require 'truty/english'
require 'truty/french'
require 'truty/czech'

# A Ruby library which is a simple string converter, which aims to fix all the typography imperfections of the plain text.
# @author Matěj Kašpar Jirásek
module Truty

  extend General
  extend English, French, Czech
  extend Conversion

end

