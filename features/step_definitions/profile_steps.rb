Given(/I enter the profile page/) do
  click_link "Profile"
end

Then(/I should see Profile/) do
  expect(page).to have_content('Profile')
end

When(/I enter my name/) do
  fill_in "user_preferred_name", with: "Tester"
end

When(/I change my pronouns/) do
  select "They/Them", from: "user_pronouns"
end

When(/I enter my job/) do
  fill_in "user_job", with: "SWE"
end

When(/I enter my age/) do
  fill_in "user_age", with: "20"
end

When(/I enter my likes/) do
  fill_in "user_likes", with: "jetskiing, swimming, dancing"
end

When(/I enter my dislikes/) do
  fill_in "user_dislikes", with: "sitting"
end

When(/I update my profile/) do
  click_button "Update"
end

Then(/I should see my changes/) do
  expect(page).to have_content('They/Them')
  expect(page).to have_content('Tester')
  expect(page).to have_content('20')
  expect(page).to have_content('sitting')
  expect(page).to have_content('jetskiing')
  expect(page).to have_content('swimming')
  expect(page).to have_content('dancing')
  expect(page).to have_content('SWE')





end


