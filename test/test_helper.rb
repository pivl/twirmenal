require "minitest/reporters"
require "minitest/unit"

$LOAD_PATH << File.dirname(__FILE__) + "/../lib/twirmenal" unless $LOAD_PATH.include?(File.dirname(__FILE__) )

require "twitter"

MiniTest::Reporters::use!

p "I am here"

