class NickSprint1DemoController < ApplicationController
  def index
    @gift_suggestions_count = GiftSuggestion.count
    @reminders_count = reminder.count

  end
end
