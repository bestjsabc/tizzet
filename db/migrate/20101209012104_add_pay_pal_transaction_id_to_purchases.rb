class AddPayPalTransactionIdToPurchases < ActiveRecord::Migration
  def self.up
    
    add_column :purchases, :txn_id, :string
    
  end

  def self.down
    
    remove_column :purchases, :txn_id
    
  end
end
