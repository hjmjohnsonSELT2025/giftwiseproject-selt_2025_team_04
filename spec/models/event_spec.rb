require 'rails_helper'
# make sure to run "RAILS_ENV=test rails db:seed" first!

RSpec.describe Event, type: :model do
  it "should add events" do
    @event = Event.new({:title => "test1", :description => "test event", :location => "test location", :user_id => User.find_by(:email => "a@b.c").id})
    expect(@event.save).to eq(true)
    expect(Event.find_by(:title => "test1").description).to eq("test event")
  end

  it "should reference a user" do
    @event = Event.new({:title => "test1", :description => "test event", :location => "test location", :user_id => User.find_by(:email => "a@b.c").id})
    expect(@event.user.email).to eq("a@b.c")
  end

  it "should delete events" do
    @event = Event.new({:title => "test1", :description => "test event", :location => "test location", :user_id => User.find_by(:email => "a@b.c").id})
    @event.destroy
    expect(Event.find_by(:title => "test1")).to be_nil
  end
end
