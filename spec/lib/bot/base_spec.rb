RSpec.describe Bot::Base do
  describe "#handle_data" do
    it "is abstract method" do
      bot = Bot::Base.new({})

      expect { bot.handle_data }.to raise_error(NotImplementedError)
      expect { bot.handle_data }.to raise_error("Bot::Base#handle_data is an abstract method.")
    end
  end
end