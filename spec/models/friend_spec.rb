require 'rails_helper'

RSpec.describe Friend, type: :model do
  it 'does not allow duplicate friends' do
    user1=User.new(:email =>"recipient@testing.com",:password =>"123456")
    user2=User.new(:email => "friend@friend.friend", :password => "123456")
    status1 = Friend.create(user: user1, friend: user2)
    expect(status1.save).to eq(true)
    status2 = Friend.create(user: user2, friend: user1)
    expect(status2.save).to eq(true)

    status1 = Friend.new(user: user1, friend: user2)
    status2 = Friend.new(user: user2, friend: user1)
    expect{ status1.save }.to raise_error(ActiveRecord::RecordNotUnique)
    expect{ status2.save }.to raise_error(ActiveRecord::RecordNotUnique)
  end
end
