require_relative 'simple_autoloader'

# config object
config = Config::EnvLoader.new

http_communication_class = HttpCommunication::NetHttp

# slack client
client = Client::Fye.new(
    config: config,
    rtm_start: Client::RtmStart.new(config: config, http_communication_class: http_communication_class),
    bot: Bot::RubyDoc,
    bot_params_class: Bot::Parameters
)

client.start



