RSpec.describe Bot::RubyDoc do
  describe "#handle_data" do
    it "returns immediately unless data is message" do
      data = double(:data, type: 'not_message')
      bot = Bot::RubyDoc.new(data)
      allow(bot).to receive(:`)

      bot.handle_data

      expect(bot).not_to have_received(:`)
    end

    it "calls cli command ri" do
      data = double(:data, type: Bot::RubyDoc::TYPE_MESSAGE, text: 'cmd')
      bot = Bot::RubyDoc.new(data)
      allow(bot).to receive(:`).and_return('')

      bot.handle_data

      expect(bot).to have_received(:`).once
    end

    it "yields block when given" do
      test_string = 'test'
      data = double(:data, type: Bot::RubyDoc::TYPE_MESSAGE, text: 'cmd')
      bot = Bot::RubyDoc.new(data)
      allow(bot).to receive(:`).and_return(test_string)

      expect { |b| bot.handle_data(&b) }.to yield_control.once
      expect { |b| bot.handle_data(&b) }.to yield_with_args(test_string)
    end

    it "yields block multiple times when response is longer" do
      quantity = 3
      test_string = 't' * quantity * Bot::RubyDoc::MESSAGE_LIMIT
      data = double(:data, type: Bot::RubyDoc::TYPE_MESSAGE, text: 'cmd')
      bot = Bot::RubyDoc.new(data)
      allow(bot).to receive(:`).and_return(test_string)

      expect { |b| bot.handle_data(&b) }.to yield_control.exactly(quantity)
    end

    it "yields with unknown_command  when ri returns nil" do
      unknown_command = "Sorry! I can't recognize that command :("
      data = double(:data, type: Bot::RubyDoc::TYPE_MESSAGE, text: 'cmd')
      bot = Bot::RubyDoc.new(data)
      allow(bot).to receive(:`).and_return(nil)

      expect { |b| bot.handle_data(&b) }.to yield_control.once
      expect { |b| bot.handle_data(&b) }.to yield_with_args(unknown_command)
    end
  end
end