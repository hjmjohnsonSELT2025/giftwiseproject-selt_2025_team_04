class Gift < ApplicationRecord
  belongs_to :user # aka the buyer
  belongs_to :event, optional: true

  validates :user, presence: true
  validates :price, presence: true,  numericality: {greater_than_or_equal_to: 0}
end
