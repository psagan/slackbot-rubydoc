# Class responsible for bot to handle Ruby documentation in ri
module Bot
  class RubyDoc < Base

    # Public: this is custom implementation of handling data from Slack RTM
    #         websocket. Responsible for handling incoming data (like getting
    #         info from ri) and yielding it for further purposes.
    #
    # data - Parameters Object eg: Bot::Parameters
    #
    # Yields response chunk as String
    #
    def handle_data(data)
      return unless is_message?(data)
      response = get_ri_info(data)

      split(response).each do |message|
        yield(message) if block_given?
      end
    end

    private

    # Internal: this method is responsible for extracting data
    #           from ri documentation (ri CLI tool)
    #
    # Returns string formatted with markdown
    def get_ri_info(data)
      # redirecting errors to /dev/null as to not populate terminal
      # with info that command not found in ri
      result = %x{ri --no-interactive -f markdown "#{data.text}" 2>/dev/null}
      result.empty? ? unknown_command : result
    end

    # Internal: method responsible for returning
    #           message when command is not found in ri documentation.
    #
    # Returns String
    def unknown_command
      "Sorry! I can't find this info in ri :("
    end

    # Internal: in evolution of this project this method should properly
    #           split markdown or other formats of text (based on LIMIT).
    #
    # Returns Array of Strings
    def split(response)
      super
    end

  end
end