# This class is responsible for using
# environment variables as object's messages (instances of this class).
#
# So if you have for example SLACK_BOT_TOKEN in ENV['SLACK_BOT_TOKEN']
# you will be able to get it's value by simply calling:
#
# Examples
#
#   config_object = Config::EnvLoader
#   config_object.slack_bot_token
#
module Config

  # Custom error class for config.
  # This is placed here as belongs to config namespace
  # And at this stage there is only EnvLoader available
  # so I've placed it here to not complicate design.
  class NoConfigOptionSetError < StandardError
  end

  class EnvLoader
    # Constant containing available config options
    AVAILABLE_CONFIG_OPTIONS = %i{slack_bot_token}.freeze

    # Public: this method is responsible for dynamically fetching
    #         environment variables (uses build-in method_missing
    #         functionality)
    #
    # String - name of the method
    #
    # Examples
    #   config_object = Config::EnvLoader # instantiate it
    #   config_object.slack_bot_token     # will fetch ENV['SLACK_BOT_TOKEN']
    #
    # Raises NoMethodError if method name doesn't exist in
    #                      AVAILABLE_CONFIG_OPTIONS
    # Raises NoConfigOptionSetError if environment variable is not set
    # Returns String - value of environment variable
    def method_missing(name)
      env_name = prepare_name(name)
      raise NoMethodError, "Config option '#{name}' not available." unless AVAILABLE_CONFIG_OPTIONS.include?(name)
      raise NoConfigOptionSetError, "No environment config option #{env_name} set" unless ENV.include?(env_name)
      ENV[env_name]
    end

    private

    # Internal: helper method to prepare name.
    #           To string and upcase.
    #           ":slack_bot_token" is changed to "SLACK_BOT_TOKEN"
    #
    # Returns String.
    def prepare_name(name)
      name.to_s.upcase
    end
  end
end