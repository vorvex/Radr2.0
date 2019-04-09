class AddUserToSession < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :user_id, :reference
  end
end
