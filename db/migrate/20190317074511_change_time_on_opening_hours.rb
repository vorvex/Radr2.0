class ChangeTimeOnOpeningHours < ActiveRecord::Migration[5.2]
  def change
    change_column :opening_hours, :start_time, :string
    change_column :opening_hours, :end_time, :string
  end
end
