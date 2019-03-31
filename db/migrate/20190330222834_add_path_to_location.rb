class AddPathToLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :path, :string
  end
end
