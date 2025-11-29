class FriendsController < ApplicationController
  def index
    @user = current_user
    @friends = @user.friends.all
    @requests = @user.incoming_requests.all
  end

  def show
    @friend = User.find(params[:id])
    @username = @friend.email[0,@friend.email.index('@')]
  end

  def accept_request
    @user = current_user
    friend_request = FriendRequest.find(params[:id])
    Friend.create(user: friend_request.requester, friend: friend_request.requestee)
    Friend.create(friend: friend_request.requester, user: friend_request.requestee)
    friend_request.destroy
    flash[:notice] = "Friend request accepted!"
    redirect_to friends_path
  end

  def create_request
    @user = current_user
    @requestee = User.find(params[:id])
    @friend_request = FriendRequest.create(requester: @user, requestee: @requestee)
    if @friend_request.save
      flash[:notice] = "Friend request sent."
    else
      flash[:notice] = "Friend request failed."
    end
    redirect_to friends_path
  end

  def search
    @user = current_user
    @friends = @user.friends.all
    @requests = @user.incoming_requests.all

    search_term = params[:search][:search_term]
    if search_term.empty?
      flash[:notice] = "Invalid search term"
      render :index
      return
    end
    @results = User.where('email LIKE ?', search_term+'%').where.not(id: @user.id).limit(10)
    if @results.empty?
      flash[:notice] = "No users found."
    end
    render :index
  end
end
