class CreateOrganizerRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :organizer_requests do |t|
      t.integer :organizer_id
      t.integer :event_id
      t.boolean :accepted

      t.timestamps
    end
  end
end
