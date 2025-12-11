Given(/the test user logs in/) do
  visit "/users/sign_up"
  fill_in "Email", with: "capybara@test.test"
  fill_in "Password", with: "123456"
  fill_in "Password confirmation", with: "123456"
  click_button "Sign up"
end

Given(/the test recipient exists/) do
  click_link("View all events")
  click_link("More about test event")
  click_link("create a recipient")
  fill_in :recipient_name, with: "test"
  fill_in :recipient_age, with: 50
  fill_in :recipient_occupation, with: "tester"
  fill_in :recipient_budget, with: 300
  click_button "Create"
  #puts page.body
  visit root_path
end

Then(/I should see Welcome, (.*)/) do |name|
  expect(page).to have_content("Welcome, #{name}")
end

When(/I click (.*)/) do |link|
  click_link(link)
  puts page.body
end

When(/I submit my gift info/) do
  fill_in "Name", with: "plates"
  fill_in "Description", with: "for eating"
  fill_in "Price", with: 20
  select "Everyone", :from => :gift_visibility
  click_button "Create"
end

Then(/I should see the new gift details page/) do
  expect(page).to have_content("Details about plates")
end

When(/I submit bad gift info/) do
  fill_in "Name", with: "forks"
  fill_in "Description", with: "for throwing"
  fill_in "Price", with: -15
  click_button "Create"
end

Then(/I should see an error message/) do
  expect(page).to have_content("Could not save gift")
end
