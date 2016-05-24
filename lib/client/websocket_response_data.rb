# This class is responsible for handling websocket response data - retrieved
# from websocket.
module Client
  class WebsocketResponseData

    # Public: initialize
    #
    # Hash - with params which are required:
    #        :data - incoming data from websocket (json string)
    #        :bot_params_class - class for parameters object eg:
    #                            Bot::Parameters
    #
    def initialize(params)
      @data = prepare_income_data(params.fetch(:data))
      @bot_params_class = params.fetch(:bot_params_class)
    end

    # Public: responsible for creating bot params instance (parameter object)
    #
    # Returns Object which is parameter object for bot, eg: Bot::Parameters
    def bot_params
      @bot_params ||= bot_params_class.new(
          type: data['type'],
          text: data['text'],
          channel: data['channel']
      )
    end

    private

    # Internal: responsible for preparing income data which are
    #           in JSON format in this case
    #
    # Returns String.
    def prepare_income_data(data)
      JSON.parse(data)
    end

    attr_reader :data, :bot_params_class

  end
end