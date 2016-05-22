require_relative 'simple_autoloader'

# config object
config = Config::EnvLoader.new
token = config.slack_bot_token


resp = JSON.parse(Net::HTTP.get(URI("https://slack.com/api/rtm.start?token=#{token}")))

EM.run {
  ws = Faye::WebSocket::Client.new(resp["url"])

  ws.on :message do |event|
    data = JSON.parse(event.data)
    p data
    if data["text"] == "say"

      wroom = {
          id: 1,
          type: 'message',
          channel: data["channel"],
          text: "test"
      }

      ws.send(JSON.generate(wroom))
    end
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
    ws = nil
  end
}