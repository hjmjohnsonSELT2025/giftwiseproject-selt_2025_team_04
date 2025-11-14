class Recipient < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :age,numericality: {greater_than: 0}
  validates :budget , numericality: {greater_than_or_equal_to: 0}, allow_nil: true

end
