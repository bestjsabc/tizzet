class FixProductTableAgain < ActiveRecord::Migration
  def self.up
    rename_column :products, :individual_seats, :individual_sales
  end

  def self.down
    rename_column :products, :individual_sales, :individual_seats
  end
end
