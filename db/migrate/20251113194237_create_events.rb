class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :location
      t.string :theme
      t.text :description
      t.datetime :date

      t.timestamps
    end
  end
end
