
class Event < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :gifts
  has_and_belongs_to_many :recipients
  has_and_belongs_to_many :users

  validates :owner, presence: true
end
