class AddPlanToEvents < ActiveRecord::Migration[5.2]
  def change
     add_column :events, :plan, :string, default: 'free'
  end
end
