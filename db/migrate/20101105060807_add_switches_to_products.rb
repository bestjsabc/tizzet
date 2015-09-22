class AddSwitchesToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :hot_ticket_pick, :boolean, :default => false
    add_column :products, :status, :integer
  end

  def self.down
    remove_column :products, :active
    remove_column :products, :hot_ticket_pick
  end
end
