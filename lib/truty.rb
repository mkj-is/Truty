#!/usr/bin/ruby

require 'uri'
require 'text/hyphen'
require 'truty/general'
require 'truty/czech'

# A Ruby library which is a simple string converter, which aims to fix all the typography imperfections of the plain text.
# @author Matěj Kašpar Jirásek
module Truty

  extend General
  extend Czech

end

