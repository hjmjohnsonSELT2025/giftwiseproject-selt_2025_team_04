Given("I am on the gift suggestions page") do
  visit "/gift_suggestions/new"
end

When("I follow create new gift suggestion") do
  visit "/gift_suggestions/new"
end


Then("I should be on the gift suggestions page") do
  expect(current_path).to eq("/gift_suggestions/new")
end
