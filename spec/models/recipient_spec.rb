require 'rails_helper'

RSpec.describe Recipient, type: :model do
  it "valid attribute creation" do
    test_user=User.create(:email =>"recipient@testing.com",:password =>"1234")
    test=Recipient.new(
      name:"test_user",
      age:"23",
      occupation:"teacher",
      hobbies:"swimming,sports",
      likes: "coding",
      dislikes:"spiders",
      budget: 400,
      user: test_user)
    expect(test.valid?).to be true
  end
  it "requires a name" do
    test_user=User.create(:email =>"recipient@testing.com",:password =>"1234")
    test=Recipient.new(age: 24,user: test_user)
    expect(test.valid?).to be false
  end

  it "does not allow negative ages" do
    test_user=User.create(:email =>"recipient@testing.com",:password =>"1234")
    test=Recipient.new(name: "test",age: -4, user: test_user)
    expect(test).not_to be_valid
  end

  it "does not allow negative budget" do
    test_user=User.create(:email =>"recipient@testing.com",:password =>"1234")
    test=Recipient.new(name: "test",budget: -4,user: test_user)
    expect(test).not_to be_valid
  end

  it "fails without user" do
    test_user=User.create(:email =>"recipient@testing.com",:password =>"1234")
    test=Recipient.new(name: "test",user: nil)
    expect(test).not_to be_valid
  end
end
