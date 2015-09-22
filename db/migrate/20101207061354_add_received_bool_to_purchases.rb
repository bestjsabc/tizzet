class AddReceivedBoolToPurchases < ActiveRecord::Migration
  def self.up
    
    add_column :purchases, :received, :boolean
    
  end

  def self.down
    
    remove_column :purchases, :received
    
  end
end
