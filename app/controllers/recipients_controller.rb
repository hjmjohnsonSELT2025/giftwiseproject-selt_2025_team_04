
class RecipientsController < ApplicationController
  before_action :authenticate_user!
  def recipient_params
    params.require(:recipient).permit(:name,:age,:occupation,:hobbies,:likes,:dislikes,:budget)
  end

  def show
    id=params[:id]
    @recipient=current_user.recipients.find(id)
  end

  def index
    @recipients=current_user.recipients.order(created_at: :desc)
  end

  def new
    @recipient=current_user.recipients.build
  end

  def create
    @recipient=Recipient.new(recipient_params)
    @recipient.user=current_user

    if @recipient.save
      flash[:notice]="#{@recipient.name} was successfully created."
      redirect_to recipients_path
    else
      flash[:warning]="enter valid characteristics"#temporary for first sprint
      redirect_to recipients_path
    end
  end

  def edit
    @recipient=current_user.recipients.find(params[:id])
  end

  def update
    @recipient=current_user.recipients.find(params[:id])
    if @recipient.update(recipient_params)
      flash[:notice]="#{@recipient.name} was successfully updated."
      redirect_to recipients_path
    else
      flash[:warning]="enter valid characteristics"#temporary for first sprint
      redirect_to recipients_path
    end
  end

  def destroy
    @recipient=current_user.recipients.find(params[:id])
    @recipient.destroy
    flash[:notice]="#{@recipient.name} was removed."
    redirect_to recipient_path
  end

end
