require 'rails_helper'

RSpec.describe Reminder, type: :model do
  it "should add reminders" do
    rt = Reminder.new(
      send_at: 1.day.from_now,
      status: "pending",
      channel: "in_app"
    )
    expect(rt).to be_valid
  end

  it "should not allow reminder without send_at" do
    @reminder = Reminder.new(
      :status  => "pending",
      :channel => "in_app"
    )

    expect(@reminder).not_to be_valid
    expect(@reminder.errors[:send_at]).to be_present

  end
end

