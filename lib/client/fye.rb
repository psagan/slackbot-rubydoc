module Client
  class Fye
    def initialize(params)
      # params are required, so fetch will raise Exception when no param provided
      @config = params.fetch(:config)
      @rtm_start = params.fetch(:rtm_start)
      @bot = params.fetch(:bot)
      @bot_params_class = params.fetch(:bot_params_class)
    end

    def start
      # Eventmachine run
      EM.run do
        # set what to do on message from websocket
        on_message

        # set what to do on close of websocket connection
        on_close
      end
    end

    private

    def on_message
      websocket_client.on(:message) do |event|
        ws = websocket_data_class.new(data: event.data, bot_params_class: bot_params_class)

        bot.new(ws.bot_params).handle_data do |response|
          websocket_client.send(ws.data_to_send(response))
        end
      end
    end

    def on_close
      websocket_client.on(:close) do |event|
        p [:close, event.code, event.reason]
        websocket_client = nil
      end
    end

    def websocket_client
      @websocket_client ||= Faye::WebSocket::Client.new(rtm_start.websocket_url)
    end

    def websocket_data_class
      WebsocketData
    end

    attr_reader :config, :rtm_start, :bot, :bot_params_class

  end

end