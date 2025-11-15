require 'rails_helper'
# make sure to run "RAILS_ENV=test rails db:seed" first!

RSpec.describe Gift, type: :model do
  it "should add gifts" do
    @gift = Gift.new({:name => "test1", :description => "test gift", :price => 15.6, :user_id => User.find_by(:email => "a@b.c").id, :recipient_id => nil, :event_id => nil})
    expect(@gift.save).to eq(true)
    expect(Gift.find_by(:name => "test1").description).to eq("test gift")
  end

  it "should reference a user" do
    @gift = Gift.new({:name => "test1", :description => "test gift", :price => 15.6, :user_id => User.find_by(:email => "a@b.c").id, :recipient_id => nil, :event_id => nil})
    expect(@gift.user.email).to eq("a@b.c")
  end
end
