require 'rails_helper'

RSpec.describe GiftSuggestion, type: :model do
  it "should add gift suggestions" do
    #user_id = User.find_by(email: "lol@lol.com")
    #expect(user_id).not_to be_nil

    #@suggestion = GiftSuggestion.new({ :title => "test1", :description => "test gift idea", :estimated_price => 1500, :user_id => user.id, :recipient_id => nil, :event_id => nil})
    suggestion = GiftSuggestion.new( title: "test1", description: "test gift idea") #, :estimated_price => 1500})

    expect(suggestion).to be_valid
  end

  it "should not allow blank title" do
    suggestion = GiftSuggestion.new(title: "", description: "lol")
    expect(suggestion).not_to be_valid
    expect(suggestion.errors[:title]).to be_present

  end

  it "should not allow blank description" do
    suggestion = GiftSuggestion.new( title: "lol", description: "")
    expect(suggestion).not_to be_valid
    expect(suggestion.errors[:description]).to be_present

  end
end


