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

  def decline_request
    @user = current_user
    @friend_request = FriendRequest.find_by(requestee_id: params[:id])
    if @friend_request
      @friend_request.destroy
    end
    flash[:notice] = "Request Declined."
    redirect_to friends_path
  end

  def remove
    @user = current_user
    @friend = Friend.find_by(user: @user, friend_id: params[:id])
    if @friend
      @friend.destroy
    end
    @other_friend = Friend.find_by(user_id: params[:id], friend: @user)
    if @other_friend
      @other_friend.destroy
    end
    flash[:notice] = "Friend removed."
    redirect_to friends_path
  end

  def search
    @user = current_user
    @friends = @user.friends.all
    @requests = @user.incoming_requests.all
    @sent_requests = @user.sent_requests.all

    search_term = params[:search][:search_term]
    if search_term.empty?
      flash[:notice] = "Invalid search term."
      render :index
      return
    end
    @results = User.where('email LIKE ?', search_term+'%').where.not(id: @user.id).where.not(id: @friends.ids).limit(10)
    if @results.empty?
      flash[:notice] = "No users found."
    end
    render :index
  end
end
