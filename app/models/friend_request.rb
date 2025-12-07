class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User'

  validate :requester_is_not_requestee

  def requester_is_not_requestee
    if requester_id == requestee_id
      errors.add('Users cannot be friends with themselves')
    end
  end
end
