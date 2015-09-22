class AddSellerIdToPurchase < ActiveRecord::Migration
  def self.up

    add_column :purchases, :seller_id, :integer
    
  end

  def self.down
    
    remove_column :purchases, :seller_id
    
  end
end
