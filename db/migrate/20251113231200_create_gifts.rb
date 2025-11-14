class CreateGifts < ActiveRecord::Migration[7.1]
  def change
    drop_table :gifts, if_exists: true
    create_table :gifts do |t|
      t.string :name
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.references :recipient, null: true
      t.float :price
      t.references :event, null: true, foreign_key: true

      t.timestamps
    end
  end
end
