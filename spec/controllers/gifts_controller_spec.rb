require "rails_helper"

RSpec.describe GiftsController, type: :controller do
  describe "going to new gifts" do
    before do
      User.skip_callback(:create, :after, :send_welcome_email)
    end
    it "should render the new gift form" do
      user = User.create!(email:"user67@bruh.com", password:"password123")
      event = Event.create!(title: "christmas", owner:user)
      user.events << event
      sign_in user
      get :new, params: { event_id: event.id }
      expect(response).to render_template("new")
    end

    after do
      User.set_callback(:create, :after, :send_welcome_email)
    end
  end

  describe "creating new gifts" do
    before do
      User.skip_callback(:create, :after, :send_welcome_email)
    end
    it "should create new gifts successfully" do
      user = User.create!(email:"user67@bruh.com", password:"password123")
      sign_in user
      @params = { :gift => {:name => "test gift", :description => "gift for testing", :price => "15.5", :recipient_id => Recipient.find_by(:name => "test recipient").id, :visibility => 0} }
      # allow(Gift).to receive(:new).and_return(Gift.new(@params))
      allow(controller).to receive(:current_user).and_return(User.find_by(:email => "a@b.c"))
      post :create, params: @params
      expect(response).to redirect_to("/gifts/2")
    end

    after do
      User.set_callback(:create, :after, :send_welcome_email)
    end
  end
end
