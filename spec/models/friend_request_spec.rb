require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  it 'does not allow to send requests to self' do
    user=User.new(:email =>"recipient@testing.com",:password =>"123456")
    friend_request = FriendRequest.create(requester_id: user, requestee_id: user)
    expect(friend_request.save).to eq(false)
  end
end
