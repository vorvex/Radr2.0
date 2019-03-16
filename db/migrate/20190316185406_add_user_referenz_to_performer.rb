class AddUserReferenzToPerformer < ActiveRecord::Migration[5.2]
  def change
    add_column :performers, :user_id, :integer
    add_column :performers, :email, :string

  end
end
