require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome" do
    before do
      User.set_callback(:create, :after, :send_welcome_email)
    end
    it "calls the welcome action when a new user signs up" do
      obj = double
      other_obj = double
      allow(other_obj).to receive(:deliver_now).and_return(nil)
      expect(obj).to receive(:welcome).and_return(other_obj)
      expect(UserMailer).to receive(:with).with(user:instance_of(User)).and_return(obj)
      user1 = User.create!(email:"a@a.a", password:"password123")
    end
    it "sends to user with correct subject" do
      user = double("User")
      allow(user).to receive(:email).and_return("a@a.a")
      mail = UserMailer.with(user:user).welcome
      expect(mail.to).to eq(["a@a.a"])
      expect(mail.subject).to eq("Welcome to Giftwise")
    end
    it "renders the view with the users email address" do
      user = double("User")
      allow(user).to receive(:email).and_return("a@a.a")
      mail = UserMailer.with(user:user).welcome
      expect(mail.body.encoded).to include(user.email)
      expect(mail.body.encoded).to include("Welcome")
    end
  end
  describe "friend_request" do
    it "sends to user with correct subject" do
      user = double("User")
      requestee = double("User")
      allow(user).to receive(:email).and_return("a@a.a")
      allow(requestee).to receive(:email).and_return("b@b.b")
      mail = UserMailer.with(user:user, requestee:requestee).friend_request
      expect(mail.to).to eq(["a@a.a"])
      expect(mail.subject).to eq("You have a new friend request")
    end
    it "contains the user who made the request" do
      user = double("User")
      requestee = double("User")
      allow(user).to receive(:email).and_return("a@a.a")
      allow(requestee).to receive(:email).and_return("b@b.b")
      mail = UserMailer.with(user:user, requestee:requestee).friend_request
      expect(mail.body.encoded).to include(requestee.email)
    end
  end
end
