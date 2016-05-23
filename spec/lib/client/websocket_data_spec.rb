RSpec.describe Client::WebsocketData do
  describe "#bot_params" do
    it "returns proper bot params" do
      bot_params = double(:bot_params)
      bot_params_class = double(:bot_params_class, new: bot_params)
      data = {type: double(:type), text: double(:text), channel: double(:channel)}
      websocket_data = Client::WebsocketData.new(
          data: JSON.generate(data),
          bot_params_class: bot_params_class
      )

      result = websocket_data.bot_params

      expect(result).to eq(bot_params)
    end
  end

  describe "#data_to_send" do
    it "prepares proper data" do
      channel = 'channel'
      bot_params = double(:bot_params, channel: channel)
      bot_params_class = double(:bot_params_class, new: bot_params)

      data = {type: double(:type), text: double(:text), channel: channel}
      websocket_data = Client::WebsocketData.new(
          data: JSON.generate(data),
          bot_params_class: bot_params_class
      )
      response = 'response'

      result = websocket_data.data_to_send(response)

      expected = {
          "id" => Client::WebsocketData.id - 1,
          "type" => 'message',
          "channel" => channel,
          "text" => response
      }
      expect(JSON.parse(result)).to eq(expected)
    end
  end

  describe "::id" do
    it "increments id" do
      initial_value = Client::WebsocketData.id

      expect(Client::WebsocketData.id).to eq(initial_value + 1)
      expect(Client::WebsocketData.id).to eq(initial_value + 2)
      expect(Client::WebsocketData.id).to eq(initial_value + 3)
    end
  end
end