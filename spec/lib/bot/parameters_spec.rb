RSpec.describe Bot::Parameters do
  it "returns set parameters" do
    input = {
       type: 't1',
       channel: 't2',
       user: 't3',
       text: 't4',
       ts: 't5',
       team: 't6'
    }

    bot_parameters = Bot::Parameters.new(input)

    input.each do |k, v|
      expect(bot_parameters.send(k)).to eq(v)
    end
  end

  it "does not set params which are not available" do
    input = {
        not_available: 't1',
        type: 't2'
    }

    bot_parameters = Bot::Parameters.new(input)

    expect(bot_parameters.type).to eq(input[:type])
    expect { bot_parameters.not_available }.to raise_error(NoMethodError)
  end

end