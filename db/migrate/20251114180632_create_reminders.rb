class CreateReminders < ActiveRecord::Migration[7.1]
  def change
    create_table :reminders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.datetime :send_at
      t.string :status
      t.string :channel

      t.timestamps
    end
  end
end
