class FixProductTable < ActiveRecord::Migration
  def self.up
    add_column :products, :price_in_cents, :integer
  end

  def self.down
    remove_column :products, :price_in_cents
  end
end
