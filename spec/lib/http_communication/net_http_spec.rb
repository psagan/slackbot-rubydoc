RSpec.describe HttpCommunication::NetHttp do
  describe "#content" do
    it "returns body when response is success" do
      uri = ''
      body = double(:body)
      result = double(:result, body: body, is_a?: true)
      communication = HttpCommunication::NetHttp.new(uri)
      allow(Net::HTTP).to receive(:get_response).and_return(result)

      result = communication.content

      expect(result).to eq(body)
    end

    it "returns empty string when response is not success" do
      uri = ''
      body = double(:body)
      result = double(:result, body: body, is_a?: false)
      communication = HttpCommunication::NetHttp.new(uri)
      allow(Net::HTTP).to receive(:get_response).and_return(result)

      result = communication.content

      expect(result).to eq('')
    end
  end
end