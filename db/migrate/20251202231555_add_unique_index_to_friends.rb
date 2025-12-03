class AddUniqueIndexToFriends < ActiveRecord::Migration[7.1]
  def change
    add_index :friends, [:user_id, :friend_id], unique: true
  end
end
