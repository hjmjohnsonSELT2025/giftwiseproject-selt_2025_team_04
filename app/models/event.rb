
class Event < ApplicationRecord
  belongs_to :user
  has_many :gifts
  has_and_belongs_to_many :recipients

  validates :user, presence: true
end
