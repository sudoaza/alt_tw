require 'minitest/autorun'
require 'alt_tw'

class AltTwitterTest < Minitest::Test
  def test_gets_any_tweet
    t = AltTwitter::Twitter.new
    tweets = t.user_timeline('twitter')
    refute_empty tweets
    assert_kind_of AltTwitter::Tweet, tweets.first
  end
end
