class CreateGifts < ActiveRecord::Migration[7.1]
  def change
    create_table :gifts do |t|
      t.string :name
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.references :recipient
      t.float :price
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
