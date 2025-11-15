Given("I am logged in") do
  visit "/users/sign_up"
  fill_in "Email", with: "test@test.com"
  fill_in "Password", with: "123456"
  fill_in "Password confirmation", with: "123456"
  click_button "Sign up"
  @user=User.find_by(email: "test@test.com")
end

When("I visit the recipients page") do
  visit recipients_path
end

Then("I should see {string}") do |string|
  expect(page).to have_content(string)
end

When("I visit the new recipient page") do
  visit new_recipient_path
end

When("I fill in {string} with {string}") do |attribute,value|
  fill_in attribute, with: value
end

When("I press {string}") do |button|
  click_button button
end

Given("a recipient named {string}") do |name|
  @recipient=Recipient.create(name: name,age:21, occupation: "developer", budget:0,user:@user)
end

When("I visit the edit page for {string}") do |name|
  recipient=Recipient.find_by(name: name)
  visit edit_recipient_path(recipient)
end