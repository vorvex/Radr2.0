class CreatePageViews < ActiveRecord::Migration[5.2]
  def change
    create_table :page_views do |t|
      t.string 'referrer'
      t.string 'params'
      t.string 'path'
      t.references 'session_id'
      t.string 'user_agent'
      t.timestamps
    end
  end
end
