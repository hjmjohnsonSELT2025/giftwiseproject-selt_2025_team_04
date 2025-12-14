When(/I submit my comment info/) do
  fill_in "gift_comment_content", with: "test content for cucumber"
  click_button "Post Comment"
end

Then(/I should see the new comment on the gift details page/) do
  expect(page).to have_content("test content for cucumber")
end

Given(/the test gift exists/) do
  click_link("Events")
  click_link("View Event")
  click_link("Add Gift")
  fill_in "Name", with: "plates"
  fill_in "Description", with: "for eating"
  fill_in "Price", with: 20
  select "Everyone", :from => :gift_visibility
  click_button "Create"
  visit root_path
end
