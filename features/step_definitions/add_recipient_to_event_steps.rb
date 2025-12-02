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
  expect(page).to have_content(/Recipients:\stest/)
end