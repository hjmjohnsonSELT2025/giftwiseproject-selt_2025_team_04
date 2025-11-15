When(/I submit my event info/) do
  fill_in "Title", with: "Birthday"
  fill_in "Location", with: "My House"
  fill_in "Theme", with: "Surprise Party"
  fill_in "Description", with: "Surprise Party Description"
  click_button "Create Event"
end

Then(/I should see the new event on the home page/) do
  expect(page).to have_content("Birthday")
end