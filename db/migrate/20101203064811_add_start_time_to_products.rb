class AddStartTimeToProducts < ActiveRecord::Migration
  def self.up
    
    add_column :products, :start_time, :time
    
  end

  def self.down
    
    remove_column :products, :start_time
    
  end
end
