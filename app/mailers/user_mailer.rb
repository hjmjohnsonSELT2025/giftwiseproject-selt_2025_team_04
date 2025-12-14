class UserMailer < ApplicationMailer

  def welcome
    @user = params[:user]
    @url  = "https://team04-selt-giftwise-1-a3750c52197c.herokuapp.com/users/sign_in"
    mail(to: @user.email, subject: "Welcome to Giftwise")
  end
  def event_add
    @user = params[:user]
    @event = params[:event]
    @url  = "https://team04-selt-giftwise-1-a3750c52197c.herokuapp.com/users/sign_in"
    mail(to: @user.email, subject: "You have been added to an event")
  end
  def friend_request
    @url  = "https://team04-selt-giftwise-1-a3750c52197c.herokuapp.com/users/sign_in"
    @user = params[:user]
    @requestee = params[:requestee]
    mail(to:@user.email, subject: "You have a new friend request")
  end
end
