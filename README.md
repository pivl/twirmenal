# Twirmenal

A  simple Twitter Terminal app

## Installation

Add this line to your application's Gemfile:

    gem 'twirmenal'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twirmenal

## Usage

After installing it you can run it with

    $ twirmenal

Available commands after you run it:

    authorize - authorize Twirmenal as your twitter application
    recent count - show the most recent tweets in your timeline, for example type "recent 3"
    post "new tweet" - posts a new tweet

After using authorize command access token information is stored locally in ~/.twirmenal

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
