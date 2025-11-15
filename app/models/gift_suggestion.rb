class GiftSuggestion < ApplicationRecord
  #belongs_to :user
  # belongs_to :recipient, optional: true
  #belongs_to :event, optional: true

  validates :title, presence: true
  validates :description, presence: true

  # validates :estimated_price, presence: true,  numericality: {greater_than_or_equal_to: 0},  allow_nil: true

end