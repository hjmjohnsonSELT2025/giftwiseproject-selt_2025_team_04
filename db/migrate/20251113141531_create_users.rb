class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    drop_table(:users, if_exists: true)
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :session_token

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :password_digest
    add_index :users, :session_token, unique: true
  end
end
