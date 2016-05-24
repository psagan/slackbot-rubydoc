# This is main Client class to utilize Faye::WebSocket::Client (which
# is known dependency inside this class). This class is responsible
# for running connection with websocket and utilizing bot functionality.
module Client
  class Fye

    # Public: initialize
    #
    # Hash - params hash with required items.
    #        Params are required, so fetch will raise Exception when no
    #        param provided. Params are:
    #        :config - config object
    #        :rtm_start - rtm start object
    #        :bot - bot class (not object)
    #        :bot_params_class - class for parameters object (not object)
    #
    def initialize(params)
      @config = params.fetch(:config)
      @rtm_start = params.fetch(:rtm_start)
      @bot = params.fetch(:bot)
      @bot_params_class = params.fetch(:bot_params_class)
    end

    # Public: main method to start operation.
    #         Uses Eventmachine and adds two watchers
    #         on_message and on_close.
    #
    # Returns nothing.
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

    # Internal: method responsible for handling event when message
    #           arrives from websocket.
    #
    # Returns nothing.
    def on_message
      websocket_client.on(:message) do |event|
        ws = websocket_data_class.new(data: event.data, bot_params_class: bot_params_class)

        bot.new(ws.bot_params).handle_data do |response|
          websocket_client.send(ws.data_to_send(response))
        end
      end
    end

    # Internal: method responsible for handling event when websocket is
    #           closed.
    #
    # Returns nothing.
    def on_close
      websocket_client.on(:close) do |event|
        p [:close, event.code, event.reason]
      end
    end

    # Internal: Get websocket client. There is known dependency in this
    #           class and this is intended as this class utilizes
    #           "Faye::WebSocket::Client"
    #
    # Returns Faye::WebSocket::Client
    def websocket_client
      @websocket_client ||= Faye::WebSocket::Client.new(rtm_start.websocket_url)
    end

    # Internal: Get WebsocketData class. There is known dependency
    # as this class is coupled with WebsocketData which is it's helper class on
    # this stage of development. Using method (message) to get this class as
    # it can be easily changed by Dependency Injection in the future.
    def websocket_data_class
      WebsocketData
    end

    attr_reader :config, :rtm_start, :bot, :bot_params_class

  end
end