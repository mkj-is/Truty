
require 'test_helper'

class TrutyEnglishTest < Test::Unit::TestCase

  def test_english
    paragraph = 'One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his bed into a horrible vermin. He lay on his armour-like back, and if he lifted his head a little he could see his brown belly, slightly domed and divided by arches into stiff sections. The bedding was hardly able to cover it and seemed ready to slide off any moment. His many legs, pitifully thin compared with the size of the rest of him, waved about helplessly as he looked. "What\'s happened to me?" he thought. It wasn\'t a dream. His room, a proper human room although a little too small, lay peacefully between its four familiar walls. A collection of textile samples lay spread out on the table - Samsa was a travelling salesman - and above it there hung a picture that he had recently cut out of an illustrated magazine and housed in a nice, gilded frame. It showed a lady fitted out with a fur hat and fur boa who sat upright, raising a heavy fur muff that covered the whole of her lower arm towards the viewer. Gregor then turned to look out the window at the dull weather.'
    assert_not_equal paragraph, Truty.english(paragraph)
    assert_not_nil Truty.english(paragraph)
  end

  def test_english_text
    text = 'Thing dominion i good wherein fill every fruit.
Dry made, seed there tree subdue.
Dominion living gathered creeping gathered.
You\'re, appear, seas said morning living.
Deep. He, him likeness female.'
    converted = Truty.fix(text, :english)
    assert_not_equal text, converted
    assert_equal text.count("\n"), converted.count("\n")
  end

  def test_english_double_quotes
    assert_equal '“Hello,” he said, “I come from the deep ocean.” “Pretty cool!” she answered.', Truty.english_double_quotes('"Hello," he said, "I come from the deep ocean." "Pretty cool!" she answered.')
  end

  def test_english_single_quotes
    assert_equal "\"‘Hello,’ he said, ‘I come from the deep ocean.’ ‘Pretty cool!’ she answered. And that was their story from my point of view.\"", Truty.english_single_quotes("\"'Hello,' he said, 'I come from the deep ocean.' 'Pretty cool!' she answered. And that was their story from my point of view.\"")
  end

end
