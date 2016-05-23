RSpec.describe Client::Fye do
  describe "#start" do
    it "do proper operations on_message" do
      config = double(:config)
      rtm_start = double(:rtm_start, websocket_url: 'wss/')
      bot_instance = double(:bot_instance)
      allow(bot_instance).to receive(:handle_data) {|&block| block.call(double(:response))}
      bot = double(:bot, new: bot_instance)
      bot_params_class = double(:bot_params_class)
      websocket_client = double(:websocket_client)
      event = double(:event, data: '', code: '', reason: '')
      allow(websocket_client).to receive(:on).with(:message) {|&block| block.call(event) }
      allow(websocket_client).to receive(:on).with(:close) {|&block| block.call(event) }
      allow(websocket_client).to receive(:send)
      data_to_send = double(:data_to_send)
      websocket_data = double(:websocket_data, bot_params: '', data_to_send: data_to_send)
      allow(Client::WebsocketData).to receive(:new).and_return(websocket_data)
      allow(Faye::WebSocket::Client).to receive(:new).and_return(websocket_client)
      allow(EM).to receive(:run) {|&block| block.call }
      params = {
        config: config,
        rtm_start: rtm_start,
        bot: bot,
        bot_params_class: bot_params_class
      }
      client_fye = Client::Fye.new(params)
      allow(client_fye).to receive(:p)

      client_fye.start

      expect(websocket_client).to have_received(:send).with(data_to_send)
    end
  end
end