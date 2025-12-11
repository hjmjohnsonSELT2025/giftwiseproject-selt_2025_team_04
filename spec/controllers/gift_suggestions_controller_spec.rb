require "rails_helper"

RSpec.describe GiftSuggestionsController, type: :controller do
  let(:user) { User.create!(email: "a@a.com", password:"aaaaaa")}
  let(:event) { Event.create!(user: user, title: "Party", theme: "NBA Night")}
  let(:recipient) do
    Recipient.create!(
      user: user,
      name: "Nick",
      age: 22,
      likes:"Warriors, NBA books",
      hobbies:"Reading",
      budget: 100)
  end


  before do
    sign_in user
  end

  describe "GET index" do
    it "renders the index template" do
      get :index, params: { event_id: event.id, recipient_id: recipient.id }
      expect(response).to render_template("index")
    end
  end

  describe "POST create (AI suggestions path)" do
    context "when generating AI suggestions via GiftSuggestionAi" do
      it "creates suggestions with source 'ai' from the service" do
        fake_ideas = [
          {
            title: "Warriors Signed Basketball",
            description: "A detailed replica basketball signed by a current Warriors player.",
            estimated_price: 90.0
          }
        ]

        fake_service = instance_double(GiftSuggestionAi, generate: fake_ideas)

        expect(GiftSuggestionAi).to receive(:new)
                                      .with(user: user, event: event, recipient: recipient)
                                      .and_return(fake_service)

        expect {
          post :create, params: {
            event_id:event.id,
            recipient_id: recipient.id,
            count: "1"
          }
        }.to change(GiftSuggestion, :count).by(1)

        suggestion = GiftSuggestion.last
        expect(suggestion.user).to eq            user
        expect(suggestion.event).to eq           event
        expect(suggestion.recipient).to eq       recipient
        expect(suggestion.title).to eq           "Warriors Signed Basketball"
        expect(suggestion.description).to        include "replica basketball signed"
        expect(suggestion.estimated_price).to eq 90.0
        expect(suggestion.source).to eq          "OpenAI"

        expect(response).to redirect_to(
                              event_gift_suggestions_path(event, recipient_id: recipient.id)
                            )
      end
    end

    context "when GiftSuggestionAi returns no ideas" do
      it "falls back to simple suggestions with source 'simple'" do
        fake_service = instance_double(GiftSuggestionAi, generate: [])
        allow(GiftSuggestionAi).to receive(:new).and_return(fake_service)

        expect {
          post :create, params: {
            event_id:     event.id,
            recipient_id: recipient.id,
            count: "1"
          } }.to change(GiftSuggestion, :count).by(1)

        suggestion = GiftSuggestion.last
        expect(suggestion.source).to eq "simple"
      end
    end
  end
end
