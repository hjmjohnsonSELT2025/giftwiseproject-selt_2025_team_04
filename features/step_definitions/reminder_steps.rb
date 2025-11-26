Then("pending reminder with a future send time should be valid") do
  reminder = Reminder.new(
    send_at: 1.day.from_now,
    status: "pending",
    channel: "in_app"
  )

  expect(reminder).to be_valid
end

Then("reminder without send_at should be invalid") do
  reminder = Reminder.new(
    status: "pending",
    channel: "in_app"
  )

  expect(reminder).not_to be_valid
  expect(reminder.errors[:send_at]).to be_present
end

