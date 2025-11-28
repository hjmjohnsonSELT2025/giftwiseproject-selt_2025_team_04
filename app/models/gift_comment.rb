class GiftComment < ApplicationRecord
  belongs_to :user
  belongs_to :gift
  belongs_to :parent, class_name: "GiftComment", optional: true # if we want to do nested comment threads
end
