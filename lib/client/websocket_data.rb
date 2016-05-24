# This class is responsible for handling websocket data
module Client
  class WebsocketData

    # instance attribute on singleton's class
    @id = 0

    # here we have class method
    class << self
      # Public: returns incremented id - to have it
      #         unique within one bot run
      #
      # Returns Integer
      def id
        @id += 1
      end
    end

    # Public: initialize
    #
    # Hash - hash with params which are required:
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

    # Public: responsible for preparing data to send to websocket
    #
    # String - response from bot
    #
    # Returns String.
    def data_to_send(response)
      data = {
          id: id,
          type: 'message',
          channel: bot_params.channel,
          text: response
      }
      prepare_outcome_data(data)
    end

    private

    # Internal: responsible for preparing income data which are
    #           in JSON format in this case
    #
    # Returns String.
    def prepare_income_data(data)
      JSON.parse(data)
    end

    # Internal: responsible for preparing outcome data
    #           which should be in JSON format in this case.
    #
    # Returns String.
    def prepare_outcome_data(data)
      JSON.generate(data)
    end

    # Internal: Instance proxy for using class method to fetch id
    #
    # Returns Integer.
    def id
      self.class.id
    end

    attr_reader :data, :bot_params_class
  end
end