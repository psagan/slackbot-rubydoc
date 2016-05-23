module Bot
  class Parameters

    AVAILABLE_PARAMETERS = %i{type channel user text ts team}.freeze

    attr_reader(*AVAILABLE_PARAMETERS)

    def initialize(params)
      AVAILABLE_PARAMETERS.each do |param|
        send(sprintf("%s=", param), params[param])
      end
    end

    private

    attr_writer(*AVAILABLE_PARAMETERS)

  end
end