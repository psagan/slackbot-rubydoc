# Abstract bot class
module Bot
  class Base

    TYPE_MESSAGE = 'message'.freeze

    MESSAGE_LIMIT = 4000.freeze

    def initialize(data)
      @data = data
    end

    def handle_data
      raise NotImplementedError, "#{self.class.name}#handle_data is an abstract method."
    end

    private

    def is_message?
      data.type == TYPE_MESSAGE
    end

    def split(response)
      response.chars.to_a.each_slice(4000).map(&:join)
    end

    def unknown_command
      "Sorry! I can't find this info in ri :("
    end

    attr_reader :data
  end
end