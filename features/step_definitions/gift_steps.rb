Given(/the test user logs in/) do
  visit "/users/sign_up"
  fill_in "Email", with: "capybara@test.test"
  fill_in "Password", with: "123456"
  fill_in "Password confirmation", with: "123456"
  click_button "Sign up"
end

Then(/I should see the welcome message/) do
  expect(page).to have_content("You have logged in")
end

When(/I click (.*)/) do |link|
  click_link(link)
end

When(/I submit my gift info/) do
  fill_in "Name", with: "plates"
  fill_in "Description", with: "for eating"
  fill_in "Price", with: 20
  click_button "Save Gift"
end

Then(/I should see the new gift on the home page/) do
  expect(page).to have_content("plates")
end

When(/I submit bad gift info/) do
  fill_in "Name", with: "forks"
  fill_in "Description", with: "for throwing"
  fill_in "Price", with: -15
  click_button "Save Gift"
end

Then(/I should see an error message/) do
  expect(page).to have_content("Could not save gift")
end
