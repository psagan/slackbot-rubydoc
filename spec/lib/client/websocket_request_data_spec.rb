RSpec.describe Client::WebsocketRequestData do
  describe "#data_to_send" do
    it "prepares proper data" do
      channel = 'channel'
      bot_params = double(:bot_params, channel: channel)
      message = 'response'
      websocket_request_data = Client::WebsocketRequestData.new(
          data: bot_params,
          message: message
      )

      result = websocket_request_data.data_to_send

      expected = {
          "id" => Client::WebsocketRequestData.id - 1,
          "type" => 'message',
          "channel" => channel,
          "text" => message
      }
      expect(JSON.parse(result)).to eq(expected)
    end
  end

  describe "::id" do
    it "increments id" do
      initial_value = Client::WebsocketRequestData.id

      expect(Client::WebsocketRequestData.id).to eq(initial_value + 1)
      expect(Client::WebsocketRequestData.id).to eq(initial_value + 2)
      expect(Client::WebsocketRequestData.id).to eq(initial_value + 3)
    end
  end
end