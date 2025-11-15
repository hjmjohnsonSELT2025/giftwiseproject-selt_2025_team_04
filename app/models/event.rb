
class Event < ApplicationRecord
  belongs_to :user
  has_many :gifts

  validates :user, presence: true

  scope :for_user, ->(user) { where(user: user) }
end
