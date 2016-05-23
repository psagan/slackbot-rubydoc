module Client
  class WebsocketData

    # instance attribute on singleton class
    @id = 0

    class << self
      def id
        @id += 1
      end
    end

    def initialize(params)
      @data = prepare_income_data(params.fetch(:data))
      @bot_params_class = params.fetch(:bot_params_class)
    end

    def bot_params
      @bot_params ||= bot_params_class.new(
          type: data['type'],
          text: data['text'],
          channel: data['channel']
      )
    end

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

    def prepare_income_data(data)
      JSON.parse(data)
    end

    def prepare_outcome_data(data)
      JSON.generate(data)
    end

    def id
      self.class.id
    end

    attr_reader :data, :bot_params_class
  end
end