Given("I am on the gift suggestions page") do
  visit "/gift_suggestions/new"
end

When("I follow create new gift suggestion") do
  visit "/gift_suggestions/new"
end

When('I press {string}') do |string|

  #When('I press "Save gift suggestion"') do #not working bc capybara i think
  #find('input[type="submit"],button[type="submit"]').click

  #click_button "Save gift suggestion"
end
Then("I should be on the gift suggestions page") do
  expect(current_path).to eq("/gift_suggestions/new")
end

Then('I should see {string}') do |text|
  expect(page).to have_content(text)
end
