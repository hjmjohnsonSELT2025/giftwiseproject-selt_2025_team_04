class CreateRecipients < ActiveRecord::Migration[7.1]
  def change
    create_table :recipients do |t|
      t.string :name
      t.integer :age
      t.string :occupation
      t.text :hobbies
      t.text :likes
      t.text :dislikes
      t.decimal :budget
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
