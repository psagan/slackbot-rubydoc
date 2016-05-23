# This is base (abstract) class for http communication.
# Base class provides interface for subclasses.
module HttpCommunication
  class Base
    def initialize(uri)
      @uri = uri
    end

    def content
      request
      extract_content
    end

    private

    def extract_content
      raise NotImplementedError, "#{self.class.name}#extract_content is an abstract method."
    end


    def request
      raise NotImplementedError, "#{self.class.name}#request is an abstract method."
    end

    def success?
      raise NotImplementedError, "#{self.class.name}#success? is an abstract method."
    end

    attr_reader :uri
    attr_accessor :response

  end
end