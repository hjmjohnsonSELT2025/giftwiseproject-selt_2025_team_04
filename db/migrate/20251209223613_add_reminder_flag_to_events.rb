class AddReminderFlagToEvents < ActiveRecord::Migration[7.1]
  def change
    change_table :events do |t|
      t.boolean :reminders_enabled, null: false, default: true
    end
  end
end
