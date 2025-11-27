class AddNameAgeJobUsersToUsers < ActiveRecord::Migration[7.1]
  def change
    change_table :users do |t|
      t.string :preferred_name, null: true
      t.integer :age, null: true
      t.string :job, null: true
      t.string :pronouns, null: true
    end
  end
end
