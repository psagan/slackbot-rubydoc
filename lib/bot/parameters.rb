# This is Parameter Class for creating parameters object.
# This approach is known as a good practice (we operate on object's messages)
module Bot
  class Parameters

    # Constant with available parameters
    AVAILABLE_PARAMETERS = %i{type channel user text ts team}.freeze

    attr_reader(*AVAILABLE_PARAMETERS)

    # Public: initialize for object
    #
    # Hash - with params: where key is parameter name and value is value of
    #        this parameter
    #
    def initialize(params)
      AVAILABLE_PARAMETERS.each do |param|
        send(sprintf("%s=", param), params[param])
      end
    end

    private

    # writers are private as the only place we can assign
    # values is initialize method
    attr_writer(*AVAILABLE_PARAMETERS)

  end
end