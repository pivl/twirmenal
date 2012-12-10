require "twirmenal/twitter"
require "twirmenal/version"

module Twirmenal
  class Application

    def self.start
      @app = self.new().start
    end

    COMMAND_LIST = [:authorize, :post, :recent, :exit]

    def start
      show_welcome_info
      show_available_commands
      @twitter = Twirmenal::Twitter.new()

      while true do
        command = input_command
        if not command_exists? command
          show_available_commands
        else
          perform command
        end
      end

    end

    def show_welcome_info
      puts "Welcome to Twirmenal ver.#{Twirmenal::VERSION}, a twitter terminal app"
    end

    def show_available_commands
      puts "Available commands:"
      puts "authorize - authorize Twirmenal as your twitter application"
      puts "recent [count] - show the most recent tweets in your timeline"
      puts 'post  "new tweet" - posts a new tweet'
    end

    def input_command
      puts "Enter a command>"
      command_string = gets.chomp
      # split the command_string on spaces unless in quotes
      separated = command_string.scan %r{"[^"]*"|\S+}

      command = {:name => separated[0].to_sym, :args => []}
      separated.each do |arg|
        arg.gsub!(/\A"|"\Z/, '') #remove first and last quotes if any
        command[:args] << arg unless separated[0] == arg
      end
      command
    end

    def command_exists? command
      if COMMAND_LIST.include?(command[:name].to_sym)
        true
      else
        false
      end
    end

    def perform(command = {})
      self.send(command[:name], *command[:args])
    end

    def post(*args)
      if args.size != 1
        puts 'type something like post "new tweet"'
        return nil
      end
      @twitter.post(args[0])
    end

    def authorize
      @twitter.authorize
    end

    def recent(*args)
      count = args[0]
      @twitter.recent(count == 0?5:count)
    end

  end
end
