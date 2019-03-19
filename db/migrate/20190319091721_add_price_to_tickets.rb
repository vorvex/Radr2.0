class AddPriceToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :price, :float
    add_column :tickets, :description, :text
  end
end
