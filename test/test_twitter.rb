require 'test/test_helper'

class TestTwitter < MiniTest::Unit::TestCase

  def setup
    @twitter = Twirmenal::Twitter.new()
  end

  def test_init
    assert_equal @twitter.innner_value, 23
  end

end
