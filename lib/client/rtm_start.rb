# This class is responsible for starting
# Slack's Real Time Messaging session.
# Result product of this proccess is "websocket url" introduced in
# websocket_url method.
module Client
  class RtmStart

    # Constant containing url address of api endpoint
    API_ENDPOINT = 'https://slack.com/api/'.freeze

    # Constant contains main command to run on RTM
    COMMAND = 'rtm.start'.freeze

    # Constant contains name of websocket url in response hash
    WEBSOCKET_URL = 'url'.freeze

    attr_accessor :response

    # Public: initialize
    #
    # Hash - hash with params which are required:
    #        :config - config object
    #        :http_communication_class - http communication class which respond
    #                                    to #content
    #
    def initialize(params)
      @config = params.fetch(:config)
      @http_communication_class = params.fetch(:http_communication_class)
    end

    # Public: main method to get websocket url. It starts connection
    #         and returns url
    #
    # Returns string
    def websocket_url
      request
      response[WEBSOCKET_URL]
    end

    private

    # Internal: this method is responsible for making request to RTM
    #           Assigns response
    #
    # Returns nothing.
    def request
      self.response = prepare_response(http_communication.content)
    end

    # Internal: this method gets http communication class (lazy loading)
    #
    # Returns Object which responds to #content
    def http_communication
      @http_communication ||= http_communication_class.new(uri)
    end

    # Internal: responsible for preparing uri for request
    #
    # Returns String
    def uri
      sprintf("%s/%s?token=%s", API_ENDPOINT, COMMAND, config.slack_bot_token)
    end

    # Internal: responsible for preparing response which is in JSON
    #           format in this case.
    #
    # Returns String
    def prepare_response(response)
      JSON.parse(response)
    end

    attr_reader :config, :http_communication_class

  end
end