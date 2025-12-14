class Recipient < ApplicationRecord
  belongs_to :user
  has_many :gifts, dependent: :nullify #want user to be able to see purchased gifts
  has_and_belongs_to_many :events, dependent: :destroy
  belongs_to :assigned_user, class_name: "User", optional: true

  validates :name, presence: true
  validates :age,numericality: {greater_than: 0}
  validates :budget , numericality: {greater_than_or_equal_to: 0}, allow_nil: true

end
