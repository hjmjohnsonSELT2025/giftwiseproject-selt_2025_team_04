class AddGiftSuggestionIdToGifts < ActiveRecord::Migration[7.1]
  def change
    add_column :gifts, :gift_suggestion_id, :integer
  end
end
