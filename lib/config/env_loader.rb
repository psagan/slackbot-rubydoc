module Config

  # Custom error class for config.
  # This is placed here as belongs to config namespace
  # And at this stage there is only EnvLoader available
  # so I've placed it here to not complicate design.
  class NoConfigOptionSetError < StandardError
  end


  class EnvLoader
    AVAILABLE_CONFIG_OPTIONS = %i{api_endpoint slack_bot_token}.freeze

    def method_missing(name)
      name = prepare_name(name)
      raise NoMethodError, "Config option '#{name}' not available." unless AVAILABLE_CONFIG_OPTIONS.include?(name)
      raise NoConfigOptionSetError, "No environment config option #{name} set" unless ENV.include?(name)
      ENV[name]
    end

    private

    def prepare_name(name)
      name.to_s.upcase
    end
  end
end