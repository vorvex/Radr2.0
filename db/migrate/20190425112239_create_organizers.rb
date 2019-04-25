class CreateOrganizers < ActiveRecord::Migration[5.2]
  def change
    create_table :organizers do |t|
      t.string :name
      t.text :description
      t.string :category
      t.integer :user_id
      t.string :plan
      t.boolean :online
      t.string :path

      t.timestamps
    end
  end
end
