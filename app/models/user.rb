class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :gifts
  has_many :recipients
  has_and_belongs_to_many :events
  has_many :gift_comments
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :friend, dependent: :destroy
  has_many :friends, through: :friend
  has_many :sent_requests, class_name: 'FriendRequest', foreign_key: :requester_id, dependent: :destroy
  has_many :incoming_requests, class_name: 'FriendRequest', foreign_key: :requestee_id, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:github]

  VALID_PRONOUNS = %w[He/Him She/Her They/Them Other]
  validates :pronouns, inclusion: {in: VALID_PRONOUNS}, allow_nil: true
  validates :age, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 180}, allow_nil: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
    end
  end
end
