require "rails_helper"

RSpec.describe GiftSuggestionAi do
  let(:user) { User.create!(email: "a@a.a", password: "aaaaaaa")}
  let(:event) do
    e = Event.create!(
      owner_id: user.id,
      title: "Party",
      theme: "NBA Night",
      date: Date.today)
    e.users << user if e.respond_to?(:users)
    e
  end
  let(:recipient) do
    Recipient.create!(
      user: user,
      name: "Nick",
      age: 22,
      likes:"Warriors, NBA books",
      hobbies:"Reading",
      budget: 100)
  end
  let(:service) { described_class.new(user: user, event: event, recipient: recipient) }

  # example from logging raw ai responses: Raw AI response: ["Here are two thoughtful gift ideas for
  # Nick that align with his interests:", "1. **Warriors Signed Basketball**", "- **Description**: A detailed
  # replica basketball signed by a current player from the Golden State Warriors. This collectible
  # will not only resonate with his love for reading about the game but also serve as a great piece
  # of memorabilia for low-key displays.", "- **Estimated Price**: $90.00", "2. **NBA Book Collection**",
  # "- **Description**: A curated collection of books focused on the history of the NBA, featuring titles about the Gol
  # den State Warriors and significant moments in basketball history. This will enrich
  # his reading hobby and deepen his engagement with the sport he loves.", "- **Estima
  # ted Price**: $50.00", "These gifts can contribute greatly to Nick's enjoyment of
  # NBA Night and celebrate his passion for the Warriors!"]
  #
  let(:raw_text) do
    <<~TEXT
      Here are two thoughtful gift ideas for Nick that align with his interests:

      1. **Warriors Signed Basketball**
      - **Description**: A detailed replica basketball signed by a current player from the Golden State Warriors. This collectible will not only resonate with his love for reading about the game but also serve as a great piece of memorabilia for low-key displays.
      - **Estimated Price**: $90.00

      2. **NBA Book Collection**
      - **Description**: A curated collection of books focused on the history of the NBA, featuring titles about the Golden State Warriors and significant moments in basketball history. This will enrich his reading hobby and deepen his engagement with the sport he loves.
      - **Estimated Price**: $50.00
    TEXT
  end

  describe "#parse_ideas" do
    it "parses titles, descriptions, and prices from the raw response" do
      ideas = service.send(:parse_ideas, raw_text, 2)
      expect(ideas.length).to eq 2

      first = ideas.first
      expect(first[:title]).to eq "Warriors Signed Basketball"
      expect(first[:description]).to include("A detailed replica basketball signed by a current player")
      expect(first[:estimated_price]).to eq 90.0

      second = ideas.second
      expect(second[:title]).to eq "NBA Book Collection"
      expect(second[:description]).to include("A curated collection of books focused on the history")
      expect(second[:estimated_price]).to eq 50.0
    end
  end

  describe "#generate" do
    it "returns parsed ideas from the OpenAI client without hitting the real API" do
      fake_response = double(
        "OpenAIResponse",
        choices: [
          double(message: double(content: raw_text))
        ]
      )

      fake_client = instance_double(OpenAI::Client)

      allow(OpenAI::Client).to receive(:new).and_return(fake_client)
      allow(fake_client).to receive_message_chain(:chat, :completions, :create)
                              .and_return(fake_response)

      ideas = service.generate(count: 2)
      expect(ideas.size).to eq 2
      expect(ideas.first[:title]).to eq "Warriors Signed Basketball"
      expect(ideas.second[:title]).to eq "NBA Book Collection"
    end
  end
end
