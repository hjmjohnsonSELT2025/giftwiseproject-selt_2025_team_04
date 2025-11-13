class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.datetime :date
      t.time :length
      t.string :theme

      t.timestamps
    end
  end
end
