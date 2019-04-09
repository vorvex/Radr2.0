class ChangeSessionIdForPageView < ActiveRecord::Migration[5.2]
  def change
    rename_column(:page_views, :session_id_id, :session_id)
  end
end
