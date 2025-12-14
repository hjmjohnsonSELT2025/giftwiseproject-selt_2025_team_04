class AddIdeaNotesStatusToGifts < ActiveRecord::Migration[7.1]
  def change
    add_column :gifts, :notes, :text
    add_column :gifts, :links, :text
    add_column :gifts, :status, :integer
  end
end
