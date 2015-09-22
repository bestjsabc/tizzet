class AddQtyToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :quantity, :integer, :null => false, :default => 1
  end

  def self.down
    remove_column :tickets, :quantity
  end
end
