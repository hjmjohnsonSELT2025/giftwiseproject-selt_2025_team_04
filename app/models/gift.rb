class Gift < ApplicationRecord
  belongs_to :user # aka the buyer
  belongs_to :recipient
  belongs_to :event, optional: true
  belongs_to :gift_suggestion, optional: true

  has_many :gift_comments, dependent: :destroy

  validates :user, presence: true
  validates :price, presence: true,  numericality: {greater_than_or_equal_to: 0}
end
