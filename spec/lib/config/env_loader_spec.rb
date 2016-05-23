RSpec.describe Config::EnvLoader do
  describe "#slack_bot_token" do
    it "returns env option when set" do
      config = Config::EnvLoader.new
      option = double(:option)
      allow(ENV).to receive(:include?).and_return(true)
      allow(ENV).to receive(:[]).and_return(option)

      result = config.slack_bot_token

      expect(ENV).to have_received(:[]).with('SLACK_BOT_TOKEN')
      expect(result).to eq(option)
    end

    it "raises Config::NoConfigOptionSetError when config is not set" do
      config = Config::EnvLoader.new
      allow(ENV).to receive(:include?).and_return(false)

      expect { config.slack_bot_token }.to raise_error(Config::NoConfigOptionSetError)
      expect { config.slack_bot_token }.to raise_error("No environment config option SLACK_BOT_TOKEN set")
    end
  end

  describe "any not available config" do
    it "raises NoMethodError when call for not available config option" do
      config = Config::EnvLoader.new

      expect { config.unknown }.to raise_error(NoMethodError)
      expect { config.unknown }.to raise_error("Config option 'unknown' not available.")
    end
  end
end