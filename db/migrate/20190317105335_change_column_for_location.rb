class ChangeColumnForLocation < ActiveRecord::Migration[5.2]
  def change
    rename_column(:locations, :type, :category)
  end
end
