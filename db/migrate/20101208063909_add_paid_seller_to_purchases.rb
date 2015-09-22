class AddPaidSellerToPurchases < ActiveRecord::Migration
  
  def self.up
    
    add_column :purchases, :seller_paid, :boolean
    
  end

  def self.down
    
    remove_column :purchases, :seller_paid
    
  end
end
