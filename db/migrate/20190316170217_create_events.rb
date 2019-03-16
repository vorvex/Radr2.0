class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer "location_id"  
      t.integer "performer_id"  
      t.string "name"  
      t.string "category"  
      t.string "description"  
      t.datetime "start_time"  
      t.datetime "end_time"  
      t.string "pathname", default: "/"     
      t.string "facebook_event"  
      t.string "image_url"  
      t.string "start_date"  
      t.string "end_date"  
      t.string "yt-video"  
      t.string "soundcloud"  
      t.string "status"  
      t.timestamps
    end
  end
end
