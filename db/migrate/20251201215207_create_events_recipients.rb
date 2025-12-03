class CreateEventsRecipients < ActiveRecord::Migration[7.1]
  def change
    create_table :events_recipients, id: false do |t|
      t.belongs_to :event
      t.belongs_to :recipient
    end
  end
end
