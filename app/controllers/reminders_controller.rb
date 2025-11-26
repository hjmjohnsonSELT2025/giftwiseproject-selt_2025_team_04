class RemindersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :new, :create], raise: false

  def index
    #@reminders = Reminder.upcoming
    @upcoming_reminders = []

  end

  def new
    @reminder = Reminder.new
  end

  def create
    @reminder = Reminder.new(reminder_params)
    #@reminder.status ||= "pending"
    #@reminder.channel ||= "in_app"

    # if @reminder.save
    #   redirect_to reminders_path, notice: "Reminder saved"
    #else
      flash[:notice] = "Could not save reminder"
      redirect_to reminders_path
  end

  private
  def reminder_params
    params.require(:reminder).permit(:send_at, :status, :channel)
  end
end
