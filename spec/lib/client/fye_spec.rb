RSpec.describe Client::Fye do
  describe "#start" do
    it "sends message to websocket client on_message" do
      params, websocket_client, data_to_send = prepare_params
      client_fye = Client::Fye.new(params)
      allow(client_fye).to receive(:p)

      client_fye.start

      expect(websocket_client).to have_received(:send).with(data_to_send)
    end

    it "puts data on close" do
      params, websocket_client, data_to_send, event = prepare_params
      client_fye = Client::Fye.new(params)
      allow(client_fye).to receive(:p)

      client_fye.start

      expect(client_fye).to have_received(:p).with([:close, event.code, event.reason])
    end
  end

  def prepare_params
    config = double(:config)
    rtm_start = double(:rtm_start, websocket_url: 'wss/')
    bot = double(:bot)
    allow(bot).to receive(:handle_data) {|&block| block.call(double(:response))}
    bot_params_class = double(:bot_params_class)
    websocket_client = double(:websocket_client)
    event = double(:event, data: 'd', code: 'c', reason: 'r')
    allow(websocket_client).to receive(:on).with(:message) {|&block| block.call(event) }
    allow(websocket_client).to receive(:on).with(:close) {|&block| block.call(event) }
    allow(websocket_client).to receive(:send)
    data_to_send = double(:data_to_send)
    websocket_request_data = double(:websocket_request_data, data_to_send: data_to_send)
    allow(Client::WebsocketRequestData).to receive(:new).and_return(websocket_request_data)
    websocket_response_data = double(:websocket_response_data, bot_params: '')
    allow(Client::WebsocketResponseData).to receive(:new).and_return(websocket_response_data)
    allow(Faye::WebSocket::Client).to receive(:new).and_return(websocket_client)
    allow(EM).to receive(:run) {|&block| block.call }
    params = {
        config: config,
        rtm_start: rtm_start,
        bot: bot,
        bot_params_class: bot_params_class
    }
    return params, websocket_client, data_to_send, event
  end
end