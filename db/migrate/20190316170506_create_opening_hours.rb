class CreateOpeningHours < ActiveRecord::Migration[5.2]
  def change
    create_table :opening_hours do |t|
      t.integer "location_id"  
      t.date "date"  
      t.integer "week_day"  
      t.time "start_time"  
      t.time "end_time"
      t.timestamps
    end
  end
end
