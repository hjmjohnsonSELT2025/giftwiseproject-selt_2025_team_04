require 'rails_helper'

RSpec.describe User, type: :model do
  describe "updating profile info" do
    it "does not allow invalid ages [0,100]" do
      user=User.new(:email =>"recipient@testing.com",:password =>"123456")

      expect(user.update(age:22)).to be(true)
      expect(user.update(age: -10)).to be(false)

    end

    it "does not allow invalid pronouns" do
      user=User.new(:email =>"recipient@testing.com",:password =>"123456")

      expect(user.update(pronouns:"They/Them")).to be(true)
      expect(user.update(pronouns: " ")).to be(false)

    end
  end
end
