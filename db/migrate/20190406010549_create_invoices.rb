class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.integer "user_id"  
      t.string "url"  
      t.string "pdf"
      
      t.timestamps
    end
  end
end
