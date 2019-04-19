class CreatePerformerRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :performer_requests do |t|
      t.integer 'performer_id', null: false
      t.integer 'event_id', null: false
      t.boolean 'accepted', default: false
      
      t.timestamps
    end
  end
end
