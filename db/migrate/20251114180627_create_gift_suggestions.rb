class CreateGiftSuggestions < ActiveRecord::Migration[7.1]
  def change
    create_table :gift_suggestions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipient, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :estimated_price
      t.string :source
      t.string :context_key

      t.timestamps
    end
  end
end
