class Reminder < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :event, optional: true

  validates :send_at, presence: true
  #validates :price, presence: true,  numericality: {greater_than_or_equal_to: 0}

  scope :upcoming, -> {
     where(status:pending).where("send_at >= ?", Time.current).order(:send_at)
     #idk if this is right supposed to store

  }

end