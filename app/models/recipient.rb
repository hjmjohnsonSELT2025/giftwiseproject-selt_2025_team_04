class Recipient < ApplicationRecord
  belongs_to :user
  has_many :gifts, dependent: :destroy
  has_and_belongs_to_many :events
  belongs_to :assigned_user, class_name: "User", optional: true

  validates :name, presence: true
  validates :age,numericality: {greater_than: 0}
  validates :budget , numericality: {greater_than_or_equal_to: 0}, allow_nil: true

end
