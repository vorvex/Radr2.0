class AddPaidForTilToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :paid_for_till, :date
    add_column :users, :bill_per_email, :boolean, default: false 
  end
end
