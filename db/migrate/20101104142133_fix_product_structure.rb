class FixProductStructure < ActiveRecord::Migration
  def self.up
    add_column :products, :quantity_on_hand, :integer
    add_column :products, :quantity_sold, :integer
    add_column :products, :list_until, :date
  end

  def self.down
    remove_column :products, :list_until
    remove_column :products, :quantity_sold
    remove_column :products, :quantity_on_hand
  end
end
