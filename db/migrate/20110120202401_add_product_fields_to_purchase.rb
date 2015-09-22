class AddProductFieldsToPurchase < ActiveRecord::Migration
  def self.up
    
    add_column :purchases, :event, :string
    add_column :purchases, :date, :date
    add_column :purchases, :start_time, :time
    add_column :purchases, :seating_type, :string
    add_column :purchases, :seating_block, :string
    add_column :purchases, :seating_row, :string
    add_column :purchases, :seat_number, :string
    
  end

  def self.down
    
    remove_column :purchases, :event
    remove_column :purchases, :date
    remove_column :purchases, :start_time
    remove_column :purchases, :seating_type
    remove_column :purchases, :seating_block
    remove_column :purchases, :seating_row
    remove_column :purchases, :seat_number
    
  end
end
