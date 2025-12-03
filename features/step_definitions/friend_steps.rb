Given(/I have pending friend requests/) do
  visit new_user_registration_path
  click_button "sign_out"
  click_link("Sign up")
  fill_in "user_email", with: "friend@test.test"
  fill_in "user_password", with: "123456"
  fill_in "user_password_confirmation", with: "123456"
  click_button "Sign up"
  visit "/friends"
  fill_in "search_search_term", with: "capy"
  click_button "Search"
  click_button "Add"
  click_link "Back"
  click_button "sign_out"

  visit "/users/sign_in"
  fill_in "Email", with: "capybara@test.test"
  fill_in "Password", with: "123456"
  click_button "commit"
end


Then(/I should see friend requests/) do
  expect(page).to have_content("Requests")
end

Then(/I should see accept or decline/) do
  expect(page).to have_content("Accept")
  expect(page).to have_content("Decline")
end

When(/I accept the friend request/) do
  click_button "Accept"
end

Then(/I should see the friend/) do
  expect(page).to have_content("friend")
  expect(page).to have_content("Remove")
end

Given(/I have no friends/) do
  expect(page).to have_content("You have no friends :(")
end