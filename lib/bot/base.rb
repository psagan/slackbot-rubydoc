# Abstract bot class
module Bot
  class Base

    # Constant with string representing message type in
    # data from websocket.
    TYPE_MESSAGE = 'message'.freeze

    # Constant with characters limit per message
    MESSAGE_LIMIT = 4000.freeze

    # Public: initialize
    #
    # Object - Parameters Object eg: Bot::Parameters
    #
    def initialize(data)
      @data = data
    end

    # Public: main method responsible for handling data from socket
    #
    # Raises NotImplementedError if method is not in sublcass
    def handle_data
      raise NotImplementedError, "#{self.class.name}#handle_data is an abstract method."
    end

    private

    # Internal: check if data type is message
    #
    # Returns boolean
    def is_message?
      data.type == TYPE_MESSAGE
    end

    # Internal: split response targetet for websocket into multiple chunks
    #           This is needed as slack RTM has limits: https://api.slack.com/rtm#limits
    #           Basically it's 16 kilobytes - so they
    #
    # Returns Array with chunks.
    def split(response)
      response.chars.to_a.each_slice(MESSAGE_LIMIT).map(&:join)
    end

    # Internal: Method responsible for returning common message
    #           when command is unknown.
    # Returns String
    def unknown_command
      "Sorry! I can't recognize this command :("
    end

    attr_reader :data
  end
end