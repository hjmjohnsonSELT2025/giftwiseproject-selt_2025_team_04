
class Event < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :gifts, dependent: :nullify
  has_many :gift_suggestions, dependent: :destroy
  has_and_belongs_to_many :recipients, dependent: :destroy
  has_and_belongs_to_many :users, dependent: :destroy

  validates :owner, presence: true
end
