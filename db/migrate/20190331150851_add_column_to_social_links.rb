class AddColumnToSocialLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :social_links, :event_id, :integer
  end
end
