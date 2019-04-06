class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :cc_name, :string
    add_column :users, :cc_exp_year, :string
    add_column :users, :cc_exp_month, :string
    add_column :users, :cc_last_four, :string
    add_column :users, :cc_brand, :string
    add_column :users, :cc_fingerprint, :string
    add_column :users, :subscription_id, :string  
  end
end
