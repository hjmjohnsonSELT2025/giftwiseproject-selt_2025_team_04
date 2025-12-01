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

  it "should add recipients" do
    @user = User.create(:email =>"event@testing.com",:password =>"1234")
    @event = Event.new({:title => "test event title", :description => "test event", :location => "test location", :user_id => User.find_by(:email => "a@b.c").id})
    @recipient = Recipient.new(name: "test recipient name",age: -4, user: @user)
    @event.recipients << @recipient
    expect(@event.recipients).to include(@recipient)
  end
end
