class CreateDislikes < ActiveRecord::Migration[7.1]
  def change
    create_table :dislikes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :item

      t.timestamps
    end
  end
end
