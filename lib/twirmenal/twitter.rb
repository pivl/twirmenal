require 'oauth'
require 'json'

module Twirmenal

  API_KEY = "8pthCx1k6dD2TIVEBkTzrg"
  API_SECRET = "7AwYBg1FiJcDZ6L6NDHC40Nxk1yt5kvrYa8cumIpHDQ"
  ACCESS_TOKEN_FILE = "#{Dir.home}/.twirmenal"

  class Twitter

    attr_reader :request_token, :consumer
    attr_accessor :access_token

    def initialize
      @consumer = OAuth::Consumer.new(API_KEY, #consumer key
                                      API_SECRET, # consumer secret
                                      {:site => "https://api.twitter.com"}
      )
      load_access_token
      check_authentication
    end

    def get_request_token
      @request_token = @consumer.get_request_token
    end

    def get_access_token(oauth_verifier)
      @access_token = @request_token.get_access_token({:oauth_verifier => oauth_verifier})
    end

    def authorize
      puts "Getting request token..."
      get_request_token

      if @request_token.callback_confirmed?
        puts "Please visit the following URL in your browser"
        puts "https://api.twitter.com/oauth/authorize?oauth_token=#{@request_token.token.to_s} "
        puts "and enter the pincode: "
        pincode = gets.chomp

        puts "Getting access token..."
        get_access_token(pincode)
        if (@access_token.token) && (@access_token.secret)
          store_access_token
          puts "Twirmenal is successfully authorized"
        else
          puts "Twirmenal cannot be authorized"
        end
      end
    end

    def recent(count)
      response = @consumer.request(:get,
                                   "http://api.twitter.com/1/statuses/home_timeline.json?count=#{count}&exclude_replies=false&include_rts=true",
                                   @access_token,
                                   {})
      hash = JSON.parse(response.body)
      #puts JSON.pretty_generate(hash)
      hash.each do |tweet|
        puts ""
        if tweet.include?"retweeted_status"
          to_show = tweet["retweeted_status"]
        else
          to_show = tweet
        end
        puts "Name: #{to_show["user"]["name"]}, #{to_show["user"]["screen_name"]}"
        puts "#{to_show["text"]}"
        if tweet.include?"retweeted_status"
          puts "Retweeted by: #{tweet["user"]["name"]}, #{tweet["user"]["screen_name"]}"
        end
        puts ""

      end
    end

    def post(tweet)
      response = @access_token.post('/1.1/statuses/update.json', {"status" => tweet.to_s})
      if response.code.to_s == "200"
        puts "New tweet posted"
      else
        puts "New tweet failed"
      end
    end

    def store_access_token
      File.open(ACCESS_TOKEN_FILE, "w") do |f|
        f.write(JSON.pretty_generate(@access_token.params) )
      end
    end

    def load_access_token
      unless File.exist? ACCESS_TOKEN_FILE
        return false
      end

      hash = JSON.parse( IO.read(ACCESS_TOKEN_FILE) )
      hash_with_symbols = {}
      hash.each_pair do |key,value|
        hash_with_symbols[key.to_sym] = value
      end

      if hash_with_symbols
        @access_token = OAuth::AccessToken.from_hash(@consumer,hash_with_symbols)
      end
    end

    def check_authentication
      if @access_token.respond_to?(:get)
        response = @access_token.get("/1.1/account/settings.json")
        if response.code == "200"
          values = JSON.parse(response.body)
          puts "You are authorized as #{values["screen_name"]}"
          return true
        else
          puts "Access token is not valid. Use authorize command"
          false
        end
      else
        puts "Access token is not present. Use authorize command"
      end
    end

  end

end
