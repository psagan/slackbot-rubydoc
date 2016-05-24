RSpec.describe Client::WebsocketResponseData do
  describe "#bot_params" do
    it "returns proper bot params" do
      bot_params = double(:bot_params)
      bot_params_class = double(:bot_params_class, new: bot_params)
      data = {type: double(:type), text: double(:text), channel: double(:channel)}
      websocket_response_data = Client::WebsocketResponseData.new(
          data: JSON.generate(data),
          bot_params_class: bot_params_class
      )

      result = websocket_response_data.bot_params

      expect(result).to eq(bot_params)
    end
  end
end