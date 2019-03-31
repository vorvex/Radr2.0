class AddPathToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :path, :string
  end
end
