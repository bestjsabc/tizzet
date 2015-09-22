class AddBuyerEmailToPurchases < ActiveRecord::Migration
  
  def self.up
    
    add_column :purchases, :email, :string
    
  end

  def self.down
    
    remove_column :purchases, :email
    
  end
end
