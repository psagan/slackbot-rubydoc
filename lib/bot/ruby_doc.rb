module Bot
  class RubyDoc < Base
    def handle_data
      return unless is_message?
      response = get_ri_info

      split(response).each do |r|
        yield(r) if block_given?
      end
    end

    private

    def get_ri_info
      result = %x{ri --no-interactive -f markdown "#{data.text}" }
      result.empty? ? unknown_command : result
    end

  end
end