Given("I am on the gift suggestions page") do

  user = User.create!(email: "a@a.a", password: "aaaaaaa")

  visit new_user_session_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Log in"

  visit new_gift_suggestion_path
end

When("I follow create new gift suggestion") do
  visit "/gift_suggestions/new"
end

Given("the AI test event exists") do
  user = User.find_by(email: "capybara@test.test") || User.first

  @event = Event.create!(user: user, title: "Party", theme: "NBA Night", date: Date.today)
  @recipient = Recipient.find_by!(user: user, name: "test")
end

Given("the AI service returns suggestions") do
  stub = [
    {
      title: "Warriors Signed Basketball",
      description: "A detailed replica basketball signed by a current player from the Golden State Warriors. This collectible will not only resonate with his love for reading about the game but also serve as a great piece of memorabilia for low-key displays.",
      estimated_price: 90.0
    },
    {
      title: "NBA Book Collection",
      description: "A curated collection of books focused on the history of the NBA, featuring titles about the Golden State Warriors and significant moments in basketball history.",
      estimated_price: 50.0
    }]
  GiftSuggestionAi.send(:define_method, :generate) do |count: 3|
    stub.first(count)
  end
end

When("I go to the gift suggestions page for the test event and recipient") do
  visit event_gift_suggestions_path(@event, recipient_id: @recipient.id)
end

Then("I should be on the gift suggestions page for the test event and recipient") do
  expect(current_path).to eq(event_gift_suggestions_path(@event))
  if current_url.include?("?")
    expect(URI.parse(current_url).query).to include("recipient_id=#{@recipient.id}")
  end
end

