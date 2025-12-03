class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_create :destroy_friend_request

  def destroy_friend_request
    friend_request = FriendRequest.find_by(requester: user, requestee: friend)
    if friend_request
      friend_request.destroy
      end
    end
end
