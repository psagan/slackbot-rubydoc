# This class is responsible for handling websocket request data - which will be
# send to websocket
module Client
  class WebsocketRequestData

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
    # Hash - with params which are required:
    #        :message - message to send
    #        :data    - data from websocket as Parameter Object
    #
    def initialize(params)
      @data = params.fetch(:data)
      @message = params.fetch(:message)
    end

    # Public: responsible for preparing data to send to websocket
    #
    # String - response from bot
    #
    # Returns String.
    def data_to_send
      output_data = {
          id: id,
          type: 'message', # hardcoded type here as not needed to on this stage
          # to have additional layer for handling that
          channel: data.channel,
          text: message
      }
      prepare_outcome_data(output_data)
    end

    private

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

    attr_reader :data, :message
  end
end