class Gift < ApplicationRecord
  belongs_to :user # aka the buyer
  belongs_to :recipient
  belongs_to :event, optional: true
  has_many :gift_comments

  validates :user, presence: true
  validates :price, presence: true,  numericality: {greater_than_or_equal_to: 0}
  VISIBILITY_LIST = [["Everyone", 0], ["Everyone but recipient", 1], ["No one", 2]].freeze
  STATUS_LIST = [["Idea", 0], ["Backlogged", 1], ["Purchased", 2], ["Delivered", 3], ["Wrapped", 4], ["Liked", 5]].freeze
end
