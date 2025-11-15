class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :location
      t.string :theme
      t.text :description
      t.datetime :date
      t.time :start_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
