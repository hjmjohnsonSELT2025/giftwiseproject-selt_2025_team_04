When(/I submit my comment info/) do
  fill_in "Content", with: "test content for cucumber"
  click_button "Create"
end

Then(/I should see the new comment on the gift details page/) do
  expect(page).to have_content("test content for cucumber")
end
