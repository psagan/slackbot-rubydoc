# This is base (abstract) class for http communication.
# Base class provides interface for subclasses.
module HttpCommunication
  class Base

    # Public: initialize method
    #
    # String - uri for communication
    #
    def initialize(uri)
      @uri = uri
    end

    # Public: this method is responsible for returning
    #         content from online address. First method calls request
    #         then extracts content from response.
    #
    # Returns String
    def content
      request
      extract_content
    end

    private

    # Internal: method responsible for extracting content from response
    #
    # Raises NotImplementedError when method is not defined in subclass
    def extract_content
      raise NotImplementedError, "#{self.class.name}#extract_content is an abstract method."
    end

    # Internal: method responsible for doing request
    #
    # Raises NotImplementedError when method is not defined in subclass
    def request
      raise NotImplementedError, "#{self.class.name}#request is an abstract method."
    end

    # Internal: method responsible for checking if response is success
    #
    # Raises NotImplementedError when method is not defined in subclass
    def success?
      raise NotImplementedError, "#{self.class.name}#success? is an abstract method."
    end

    attr_reader :uri
    attr_accessor :response

  end
end