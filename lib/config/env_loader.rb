module Config

  # Custom error class for config.
  # This is placed here as belongs to config namespace
  # And at this stage there is only EnvLoader available
  # so I've placed it here to not complicate design.
  class NoConfigOptionSetError < StandardError
  end


  class EnvLoader
    AVAILABLE_CONFIG_OPTIONS = %i{slack_bot_token}.freeze

    def method_missing(name)
      env_name = prepare_name(name)
      raise NoMethodError, "Config option '#{name}' not available." unless AVAILABLE_CONFIG_OPTIONS.include?(name)
      raise NoConfigOptionSetError, "No environment config option #{env_name} set" unless ENV.include?(env_name)
      ENV[env_name]
    end

    private

    def prepare_name(name)
      name.to_s.upcase
    end
  end
end