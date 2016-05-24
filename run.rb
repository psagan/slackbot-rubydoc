require_relative 'simple_autoloader'

# config object - environment variables loader
config = Config::EnvLoader.new

# instance of http communication class
http_communication_class = HttpCommunication::NetHttp

# slack client - I use Dependency Injection and aggregation (of external objects) approach here
client = Client::Fye.new(
    config: config,
    rtm_start: Client::RtmStart.new(config: config, http_communication_class: http_communication_class),
    bot: Bot::RubyDoc.new,
    bot_params_class: Bot::Parameters
)

# start it!
client.start



