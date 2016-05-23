# This class is responsible for HTTP communication:
# like making request, testing if request is successful
# and getting response content
module HttpCommunication
  class NetHttp < Base

    private

    # make request
    def request
      self.response = Net::HTTP.get_response(URI(uri))
    end

    # check if response has success status
    def success?
      response.is_a?(Net::HTTPSuccess)
    end

    def extract_content
      success? ? response.body : ''
    end

  end
end