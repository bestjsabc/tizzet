class RenameMemberIdToBuyerId < ActiveRecord::Migration
  def self.up
    
    rename_column :purchases, :member_id, :buyer_id
    
  end

  def self.down
    
    rename_column :purchases, :buyer_id, :member_id
    
  end
end
