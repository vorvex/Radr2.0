class ChangeColumnTypeForPageView < ActiveRecord::Migration[5.2]
  def change
    change_column :page_views, :user_id, :integer
    change_column :sessions, :user_id, :integer
  end
end
