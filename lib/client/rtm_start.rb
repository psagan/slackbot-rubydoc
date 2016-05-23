# This class is responsible for starting
# Slack's Real Time Messaging session.
# Result product of this proccess is "websocket url" introduced in
# websocket_url method.
module Client
  class RtmStart

    API_ENDPOINT = 'https://slack.com/api/'.freeze

    COMMAND = 'rtm.start'.freeze

    WEBSOCKET_URL = 'url'.freeze

    attr_accessor :response

    def initialize(params)
      @config = params.fetch(:config)
      @http_communication_class = params.fetch(:http_communication_class)
    end

    def websocket_url
      run
      response[WEBSOCKET_URL]
    end

    private

    def run
      self.response = prepare_response(http_communication.content)
    end

    def http_communication
      @http_communication ||= http_communication_class.new(uri)
    end

    def uri
      sprintf("%s/%s?token=%s", API_ENDPOINT, COMMAND, config.slack_bot_token)
    end

    def prepare_response(response)
      JSON.parse(response)
    end

    attr_reader :config, :http_communication_class

  end
end