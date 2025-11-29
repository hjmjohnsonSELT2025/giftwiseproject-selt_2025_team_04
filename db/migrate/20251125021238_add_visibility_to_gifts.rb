class AddVisibilityToGifts < ActiveRecord::Migration[7.1]
  def change
    add_column :gifts, :visibility, :integer, default: 0
  end
end
