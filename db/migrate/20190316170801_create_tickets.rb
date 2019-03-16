class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.integer "event_id"  
      t.string "name"  
      t.string "url"  
      t.string "status"  
      t.timestamps
    end
  end
end
