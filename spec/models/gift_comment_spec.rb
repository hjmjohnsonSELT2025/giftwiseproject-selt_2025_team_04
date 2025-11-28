require 'rails_helper'
# make sure to run "RAILS_ENV=test rails db:seed" first!

RSpec.describe GiftComment, type: :model do
  it "should add comments" do
    @gift_comment = GiftComment.new({:user_id => User.find_by(:email => "a@b.c").id, :content => "Test comment", :gift_id => Gift.find_by(:name => "test gift").id, :thread => 0})
    expect(@gift_comment.save).to eq(true)
    expect(GiftComment.find_by(:content => "Test comment").content).to eq("Test comment")
  end

  it "should belong to a user" do
    @gift_comment = GiftComment.new({:user_id => User.find_by(:email => "a@b.c").id, :content => "Test comment", :gift_id => Gift.find_by(:name => "test gift").id, :thread => 0})
    expect(@gift_comment.user.email).to eq("a@b.c")
  end
end
