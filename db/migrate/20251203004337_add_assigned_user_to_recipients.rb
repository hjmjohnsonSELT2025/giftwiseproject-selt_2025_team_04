class AddAssignedUserToRecipients < ActiveRecord::Migration[7.1]
  def change
    add_reference :recipients, :assigned_user, foreign_key: { to_table: :users }
  end
end
