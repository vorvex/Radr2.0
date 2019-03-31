class AddPathToPerformer < ActiveRecord::Migration[5.2]
  def change
    add_column :performers, :path, :string
  end
end
