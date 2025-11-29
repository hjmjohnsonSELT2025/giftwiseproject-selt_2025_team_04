Given("I am on the gift suggestions page") do

  user = User.create!(
    email: "test@example.com",
    password: "password",
    password_confirmation: "password"
  )

  visit new_user_session_path
  fill_in "Email", with: user.email
  fill_in "Password", with: "password"
  click_button "Log in"

  visit new_gift_suggestion_path
end

When("I follow create new gift suggestion") do
  visit "/gift_suggestions/new"
end



  #When('I press "Save gift suggestion"') do #not working bc capybara i think
  #find('input[type="submit"],button[type="submit"]').click

  #click_button "Save gift suggestion"
Then("I should be on the gift suggestions page") do
  expect(current_path).to eq("/gift_suggestions/new")
end
