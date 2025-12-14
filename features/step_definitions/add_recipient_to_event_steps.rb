Given(/the test event exists/) do
  click_link("Add new event")
  fill_in :event_title, with: "test event"
  click_button "commit"
  visit root_path
end

When(/I select (.*) from (.*)/) do |name, field|
  select(name, from: field)
end

Then(/I should see the recipient/) do
  fill_in :recipient_name, with: "test"
  fill_in :recipient_age, with: 50
  fill_in :recipient_occupation, with: "tester"
  fill_in :recipient_budget, with: 300
  click_button "Create"
  expect(page).to have_content("test")
end