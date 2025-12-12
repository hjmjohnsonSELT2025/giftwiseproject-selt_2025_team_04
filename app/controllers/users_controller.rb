class UsersController < ApplicationController
  after_create :send_welcome_email

  def send_welcome_email
    @user = current_user
    UserMailer.with(user: @user).welcome.deliver_now
  end

  def edit
    @user = current_user
    @likes = @user.likes.map { |like| like.item}.join(", ")
    @dislikes = @user.dislikes.map {|like| like.item}.join(", ")
  end

  def show
    @user = current_user
  end

  def update
    @user = current_user
    begin
      @user.update!(user_params)
      likes = params["user"]["likes"]
      unless likes.empty?
        @user.likes.destroy_all
        likes.split(',').each do |like|
          @user.likes.create!(item: like.strip.downcase) unless like.empty?
        end
      end

      dislikes = params["user"]["dislikes"]
      unless dislikes.empty?
        @user.dislikes.destroy_all
        dislikes.split(',').each do |dislike|
          @user.dislikes.create!(item: dislike.strip.downcase) unless dislike.empty?
        end
      end
      flash[:notice] = "Successfully updated profile"
      redirect_to user_path
    rescue
      flash[:notice] = "Unable to update profile"
      redirect_to user_path
      return
    end
  end

  def user_params
    params.require(:user).permit(:preferred_name, :age, :job, :pronouns)
  end
end
