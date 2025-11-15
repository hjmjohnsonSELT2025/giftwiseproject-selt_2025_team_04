Given("I am on the new reminder page") do
  visit "/reminders/new"
end

When("I make a reminder") do
  ear  = (Time.current.year + 1).to_s
  month = "January"
  day   = "1"

  select year,   from: "reminder_send_at_1i"
  select month,  from: "reminder_send_at_2i"
  select day,    from: "reminder_send_at_3i"
  select "09",   from: "reminder_send_at_4i"
  select "00",   from: "reminder_send_at_5i"

  fill_in "Status",  with: "pending" if page.has_field?("Status")
  fill_in "Channel", with: "in_app"  if page.has_field?("Channel")
end

When("I press {button}") do
  click_button "Create Reminder"
end

#not sending all (stubbing)
When("I fill in an invalid reminder with no send time") do
  fill_in "Status",  with: "pending" if page.has_field?("Status")
  fill_in "Channel", with: "in_app"  if page.has_field?("Channel")
end

Then("I should see a confirmation that the reminder was created") do
  expect(page).to have_content("Reminder was successfully created").or have_content("Reminder created")
end
