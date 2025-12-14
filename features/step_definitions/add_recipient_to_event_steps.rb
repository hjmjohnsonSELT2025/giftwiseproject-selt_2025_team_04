Given(/the test event exists/) do
  click_link("Add New Event")
  fill_in :event_title, with: "test event"
  click_button "commit"
  visit root_path
end

When(/I select (.*) from (.*)/) do |name, field|
  select(name, from: field)
end

Then(/I should see the recipient/) do
  expect(page).to have_content(/test/)
end

Then(/I fill out info/) do
  fill_in :recipient_name, with: "test"
  fill_in :recipient_age, with: 50
  fill_in :recipient_occupation, with: "tester"
  fill_in :recipient_budget, with: 300
  click_button "Create"
  visit root_path
end

When(/I press (.*)/) do |button|
  #puts page.body
  click_button button
end