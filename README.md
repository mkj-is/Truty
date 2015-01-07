
# Truty

[![Gem Version](https://badge.fury.io/rb/truty.svg)](http://badge.fury.io/rb/truty)
[![Test Coverage](https://codeclimate.com/github/mkj-is/Truty/badges/coverage.svg)](https://codeclimate.com/github/mkj-is/Truty)
[![Code Climate](https://codeclimate.com/github/mkj-is/Truty/badges/gpa.svg)](https://codeclimate.com/github/mkj-is/Truty)
[![Build Status](https://travis-ci.org/mkj-is/Truty.svg?branch=master)](https://travis-ci.org/mkj-is/Truty)
[![Dependency Status](https://gemnasium.com/mkj-is/Truty.svg)](https://gemnasium.com/mkj-is/Truty)
[![security](https://hakiri.io/github/mkj-is/Truty/master.svg)](https://hakiri.io/github/mkj-is/Truty/master)

A simple string converter, which aims to fix all the typography imperfections of the plain text.

The current version of the project fixes following things:

- Hyphenation
- Typographic quotes
- Non-breaking spaces
- Ellipses
- Trailing spaces
- Widows
- etc.

## Installation

The most simple way to install Truty is using Ruby gems.

```
gem install truty
```

## Usage

The gem contains an executable. For now it has only one parameter, language. Other arguments are files which will be converted and outputted. If no file is supplied, then the standard input is converted.

```
truty -l czech file.txt
```

Or:

```
truty --language english file.txt
```

Currently suported languages:

- Czech
- English (partially)
- French (partially)

## Library

If you want to use typography fixes and improvements in your code then add:

```ruby
require 'truty'
```

Main method for converting your string is:

```ruby
string = "Hello world!"
puts Truty.fix(string, :english)
```

Full documentation can be found here:

http://www.rubydoc.info/gems/truty

## Authors

- [Matěj Kašpar Jirásek](https://github.com/mkj-is) (http://mkj.is)

