class AddOrganizerIdToSocialLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :social_links, :organizer_id, :integer
  end
end
