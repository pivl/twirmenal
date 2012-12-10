require File.expand_path('../test_helper', __FILE__)

class TestTwitter < MiniTest::Unit::TestCase

  def setup
    @twitter = Twirmenal::Twitter.new()
  end

  def test_token_store
    token = OAuth::AccessToken.from_hash(@twitter.consumer, {:oauth_token => "oath_token_value",
                                                             :oauth_token_secret => "oauth_token_secret_value"})
    @twitter.access_token = token
    @twitter.store_access_token
    @twitter.load_access_token

    assert_equal(token.params[:oauth_token], @twitter.access_token.params[:oauth_token])
    assert_equal(token.params[:oauth_token_secret], @twitter.access_token.params[:oauth_token_secret])

  end

end
