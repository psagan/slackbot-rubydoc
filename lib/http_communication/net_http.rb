# This class is responsible for HTTP communication:
# like making request, testing if request is successful
# and getting response content
module HttpCommunication
  class NetHttp < Base

    private

    # Internal: make request. Assigns response.
    #
    # Returns nothing.
    def request
      self.response = Net::HTTP.get_response(URI(uri))
    end

    # Internal: check if response has success status
    #
    # Returns nothing.
    def success?
      response.is_a?(Net::HTTPSuccess)
    end

    # Internal: extracts content from response
    #
    # Returns String - empty string when response is not success
    def extract_content
      success? ? response.body : ''
    end

  end
end