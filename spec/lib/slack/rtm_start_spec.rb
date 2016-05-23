RSpec.describe Client::RtmStart do
  describe "#websocket_url" do
    it "returns websocket url" do
      websocket_url = 'wss/'
      config = double(:config, slack_bot_token: '')
      content = Hash.new
      content[Client::RtmStart::WEBSOCKET_URL] = websocket_url
      http_communication = double(:http_communication, content: JSON.generate(content))
      http_communication_class = double(:http_communication_class, new: http_communication)
      rtm_start = Client::RtmStart.new(config: config, http_communication_class: http_communication_class)

      result = rtm_start.websocket_url

      expect(result).to eq(websocket_url)
    end
  end
end
