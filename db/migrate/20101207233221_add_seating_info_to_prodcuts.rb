class AddSeatingInfoToProdcuts < ActiveRecord::Migration
  
  def self.up
  
    add_column :products, :seating_block, :string
    add_column :products, :seating_row, :string
    add_column :products, :seat_number, :string
  
  end

  def self.down
    
    remove_column :products, :seating_block
    remove_column :products, :seating_row
    remove_column :products, :seat_number
    
  end
  
end
