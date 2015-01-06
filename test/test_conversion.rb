
require 'test_helper'

class TrutyConversionTest < Test::Unit::TestCase

  def test_none
    assert_equal "test", Truty.none("test")
  end

  def test_html
    assert_equal "&bdquo;&Aacute;le&ldquo;", Truty.html("„Ále“")
  end

  def test_convert_html
    assert_equal "&bdquo;&Aacute;le&ldquo;", Truty.convert("„Ále“", :html)
  end

  def test_convert_other
    assert_equal "„Ále“", Truty.convert("„Ále“", :something)
  end

end
