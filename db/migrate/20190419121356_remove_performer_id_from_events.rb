class RemovePerformerIdFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :performer_id, :integer
  end
end
