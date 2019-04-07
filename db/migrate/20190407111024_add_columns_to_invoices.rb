class AddColumnsToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :date, :date
    add_column :invoices, :amount_due, :integer
    add_column :invoices, :amount_paid, :integer
  end
end
