class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.integer "user_id", null: false 
      t.string "name"
      t.string "type"
      t.string "formatted_address"
      t.string "route"
      t.string "street_number"
      t.string "postal_code"
      t.string "locality"
      t.string "place_id"
      t.float "lat"
      t.float "lng"     
      t.timestamps
    end
  end
end
