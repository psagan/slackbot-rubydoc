# Class responsible for bot related to Ruby documentation in ri
module Bot
  class RubyDoc < Base

    # Public: this is custom implementation of handling data from Slack RTM websocket.
    #         Responsible for handling incoming data (like getting info from ri) and yielding
    #         it for further purposes.
    #
    # Yields response chunk as String
    #
    # Returns nothing.
    def handle_data
      return unless is_message?
      response = get_ri_info

      split(response).each do |r|
        yield(r) if block_given?
      end
    end

    private

    # Internal: this method is responsible for extracting data
    #           from ri documentation (ri CLI tool)
    #
    # Returns string formatted with markdown
    def get_ri_info
      result = %x{ri --no-interactive -f markdown "#{data.text}" }
      result.empty? ? unknown_command : result
    end

    # Internal: method responsible for returning
    #           message when command is not found in ri documentation.
    #
    # Returns String
    def unknown_command
      "Sorry! I can't find this info in ri :("
    end

  end
end