class AddPaymentStatusToPurchases < ActiveRecord::Migration
  def self.up
    add_column :purchases, :payment_status, :integer
  end

  def self.down
    remove_column :purchases, :payment_status
  end
end
