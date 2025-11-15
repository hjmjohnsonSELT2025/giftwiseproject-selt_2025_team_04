
class Event < ApplicationRecord
  belongs_to :user
  has_many :gifts

  validates :user, presence: true
end
