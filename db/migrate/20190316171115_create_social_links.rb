class CreateSocialLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :social_links do |t|
      t.integer "location_id"  
      t.integer "performer_id"  
      t.string "channel"  
      t.string "url"
      t.timestamps
    end
  end
end
