class Recipient < ApplicationRecord
  belongs_to :user
  belongs_to :assigned_user, class_name: "User", optional: true
  has_many :gifts

  validates :name, presence: true
  validates :age,numericality: {greater_than: 0}
  validates :budget , numericality: {greater_than_or_equal_to: 0}, allow_nil: true

end
